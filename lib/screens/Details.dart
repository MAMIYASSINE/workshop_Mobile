import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/models/Film.dart';

class Details extends StatelessWidget {
  const Details({required this.film, required this.onBuy, super.key});

  final Film film;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(film.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/${film.image}',
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(film.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(film.description),
            const SizedBox(height: 24),
            Text(
              '${film.price.toStringAsFixed(0)} DT',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                onBuy();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Film ajouté au panier.')),
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
