import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/models/Film.dart';

class MyCart extends StatelessWidget {
  const MyCart({
    required this.films,
    required this.onRemove,
    required this.onOpen,
    required this.onCheckout,
    super.key,
  });

  final List<Film> films;
  final ValueChanged<Film> onRemove;
  final ValueChanged<Film> onOpen;
  final VoidCallback onCheckout;

  double get _total => films.fold(0, (total, film) => total + film.price);

  @override
  Widget build(BuildContext context) {
    if (films.isEmpty) {
      return const Center(child: Text('Votre panier est vide.'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: films.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final film = films[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  onTap: () => onOpen(film),
                  leading: Image.asset(
                    'assets/images/${film.image}',
                    width: 72,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  title: Text(film.title),
                  subtitle: Text('${film.price.toStringAsFixed(0)} DT'),
                  trailing: IconButton(
                    tooltip: 'Retirer du panier',
                    onPressed: () => onRemove(film),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total : ${_total.toStringAsFixed(0)} DT',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FilledButton(onPressed: onCheckout, child: const Text('Acheter')),
            ],
          ),
        ),
      ],
    );
  }
}
