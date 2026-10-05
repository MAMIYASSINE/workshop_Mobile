import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/models/Film.dart';
import 'package:workshop_flutter__4ei3/models/film_catalog.dart';
import 'package:workshop_flutter__4ei3/screens/Details.dart';
import 'package:workshop_flutter__4ei3/screens/MyCart.dart';
import 'package:workshop_flutter__4ei3/screens/profile_settings_screen.dart';

class StoreHomeScreen extends StatefulWidget {
  const StoreHomeScreen({super.key});

  @override
  State<StoreHomeScreen> createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  int _selectedTab = 0;
  final List<Film> _cart = [];
  final List<Film> _library = [];
  final Set<Film> _purchased = {};
  final Set<Film> _favorites = {};

  String get _title => switch (_selectedTab) {
    0 => 'STORE',
    1 => 'Bibliothèque',
    _ => 'Panier',
  };

  void _openDetails(Film film) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => Details(film: film, onBuy: () => _addToCart(film)),
      ),
    );
  }

  void _addToCart(Film film) {
    setState(() {
      _cart.add(film);
    });
  }

  void _toggleFavorite(Film film) {
    setState(() {
      if (_favorites.remove(film)) {
        if (!_purchased.contains(film)) _library.remove(film);
      } else {
        _favorites.add(film);
        if (!_library.contains(film)) _library.add(film);
      }
    });
  }

  void _removeFromCart(Film film) {
    setState(() => _cart.remove(film));
  }

  void _checkout() {
    if (_cart.isEmpty) return;
    setState(() {
      for (final film in _cart) {
        _purchased.add(film);
        if (!_library.contains(film)) _library.add(film);
      }
      _cart.clear();
      _selectedTab = 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Films ajoutés à votre bibliothèque.')),
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
    return switch (_selectedTab) {
      0 => _FilmCollection(
        films: filmCatalog,
        favorites: _favorites,
        onOpen: _openDetails,
        onFavorite: _toggleFavorite,
      ),
      1 => _FilmCollection(
        films: _library,
        favorites: _favorites,
        onOpen: _openDetails,
        onFavorite: _toggleFavorite,
        emptyMessage: 'Votre bibliothèque est vide.',
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
            icon: Icon(Icons.video_library_outlined),
            selectedIcon: Icon(Icons.video_library),
            label: 'Bibliothèque',
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
  final ValueChanged<Film> onOpen;
  final ValueChanged<Film> onFavorite;
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
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => onOpen(film),
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
                        tooltip: favorites.contains(film)
                            ? 'Retirer de la bibliothèque'
                            : 'Ajouter à la bibliothèque',
                        onPressed: () => onFavorite(film),
                        icon: Icon(
                          favorites.contains(film)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
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
