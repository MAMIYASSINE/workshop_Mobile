import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/helpers/database_helper.dart';
import 'package:workshop_flutter__4ei3/models/Film.dart';
import 'package:workshop_flutter__4ei3/models/film_catalog.dart';
import 'package:workshop_flutter__4ei3/screens/Details.dart';
import 'package:workshop_flutter__4ei3/screens/MyCart.dart';
import 'package:workshop_flutter__4ei3/screens/profile_settings_screen.dart';

class StoreHomeScreen extends StatefulWidget {
  StoreHomeScreen({super.key, FilmStorage? storage})
    : storage = storage ?? DatabaseHelper.instance;

  final FilmStorage storage;

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  int _selectedTab = 0;
  bool _isLoading = true;
  List<Film> _cart = [];
  List<Film> _favorites = [];

  String get _title => switch (_selectedTab) {
    0 => 'STORE',
    1 => 'Favoris',
    _ => 'Panier',
  };

  Set<Film> get _favoriteSet => _favorites.toSet();

  @override
  void initState() {
    super.initState();
    _loadSavedFilms();
  }

  Future<void> _loadSavedFilms() async {
    final cart = await widget.storage.getCartFilms();
    final favorites = await widget.storage.getFavoriteFilms();

    if (!mounted) return;
    setState(() {
      _cart = cart;
      _favorites = favorites;
      _isLoading = false;
    });
  }

  Future<void> _openDetails(Film film) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => Details(
          film: film,
          isFavorite: _favoriteSet.contains(film),
          onBuy: () => _addToCart(film),
          onFavorite: () => _toggleFavorite(film),
        ),
      ),
    );
  }

  Future<void> _addToCart(Film film) async {
    await widget.storage.addFilmToCart(film);
    final cart = await widget.storage.getCartFilms();

    if (!mounted) return;
    setState(() => _cart = cart);
  }

  Future<void> _toggleFavorite(Film film) async {
    if (_favoriteSet.contains(film)) {
      await widget.storage.removeFavorite(film);
    } else {
      await widget.storage.addFavorite(film);
    }

    final favorites = await widget.storage.getFavoriteFilms();
    if (!mounted) return;
    setState(() => _favorites = favorites);
  }

  Future<void> _removeFromCart(Film film) async {
    await widget.storage.removeFilmFromCart(film);
    final cart = await widget.storage.getCartFilms();

    if (!mounted) return;
    setState(() => _cart = cart);
  }

  Future<void> _checkout() async {
    if (_cart.isEmpty) return;

    await widget.storage.clearCart();
    if (!mounted) return;

    setState(() {
      _cart = [];
      _selectedTab = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Achat effectue avec succes.')),
    );
  }

  Future<void> _openProfile() async {
    Navigator.of(context).pop();
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => const ProfileSettingsScreen()),
    );
  }

  void _logout() {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  Widget _buildSelectedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return switch (_selectedTab) {
      0 => _FilmCollection(
        films: filmCatalog,
        favorites: _favoriteSet,
        onOpen: _openDetails,
        onFavorite: _toggleFavorite,
      ),
      1 => _FilmCollection(
        films: _favorites,
        favorites: _favoriteSet,
        onOpen: _openDetails,
        onFavorite: _toggleFavorite,
        emptyMessage: 'Votre liste des favoris est vide.',
      ),
      _ => MyCart(
        films: _cart,
        onRemove: _removeFromCart,
        onOpen: _openDetails,
        onCheckout: _checkout,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.movie_creation_rounded,
                    size: 88,
                    color: Color(0xFF202124),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Update Profile'),
                onTap: _openProfile,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: _logout,
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.chevron_right),
                title: const Text('Go to Nav Bar'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
      body: _buildSelectedTab(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Store',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            selectedIcon: Icon(Icons.shopping_basket),
            label: 'Panier',
          ),
        ],
      ),
    );
  }
}

class _FilmCollection extends StatelessWidget {
  const _FilmCollection({
    required this.films,
    required this.favorites,
    required this.onOpen,
    required this.onFavorite,
    this.emptyMessage,
  });

  final List<Film> films;
  final Set<Film> favorites;
  final Future<void> Function(Film) onOpen;
  final Future<void> Function(Film) onFavorite;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (films.isEmpty) {
      return Center(child: Text(emptyMessage ?? 'Aucun film disponible.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films[index];
        final isFavorite = favorites.contains(film);

        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () async => onOpen(film),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    'assets/images/${film.image}',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          film.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: isFavorite
                            ? 'Retirer des favoris'
                            : 'Ajouter aux favoris',
                        onPressed: () async => onFavorite(film),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
