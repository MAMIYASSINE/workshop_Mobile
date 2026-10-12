import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/models/Film.dart';

class Details extends StatefulWidget {
  const Details({
    required this.film,
    required this.isFavorite,
    required this.onBuy,
    required this.onFavorite,
    super.key,
  });

  final Film film;
  final bool isFavorite;
  final Future<void> Function() onBuy;
  final Future<void> Function() onFavorite;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film.title),
        actions: [
          IconButton(
            tooltip: _isFavorite
                ? 'Retirer des favoris'
                : 'Ajouter aux favoris',
            onPressed: () async {
              await widget.onFavorite();
              final message = _isFavorite
                  ? 'Film retire des favoris.'
                  : 'Film ajoute aux favoris.';
              if (!context.mounted) return;

              setState(() => _isFavorite = !_isFavorite);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/${widget.film.image}',
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.film.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(widget.film.description),
            const SizedBox(height: 24),
            Text(
              '${widget.film.price.toStringAsFixed(0)} DT',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () async {
                await widget.onBuy();
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Film ajoute au panier.')),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.shopping_basket),
              label: const Text('Acheter'),
            ),
          ],
        ),
      ),
    );
  }
}
