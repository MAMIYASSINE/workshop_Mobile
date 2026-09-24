import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int price;
  final VoidCallback onBuy;

  const FilmDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/$image'),
            const SizedBox(height: 70),
            Text(
              description,
              style: const TextStyle(fontSize: 20, height: 1.4),
            ),
            const SizedBox(height: 32),
            Text(
              '$price DT',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onBuy,
              icon: const Icon(Icons.shopping_basket),
              label: const Text('Acheter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}