import 'package:flutter/material.dart';

class CartItem {
  final String image;
  final String title;
  final int price;

  const CartItem({
    required this.image,
    required this.title,
    required this.price,
  });
}

class CartPage extends StatefulWidget {
  final List<CartItem> items;
  final ValueChanged<CartItem> onRemove;

  const CartPage({
    super.key,
    required this.items,
    required this.onRemove,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> items;

  @override
  void initState() {
    super.initState();
    items = List<CartItem>.of(widget.items);
  }

  void removeItem(CartItem item) {
    setState(() => items.remove(item));
    widget.onRemove(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My cart'),
        centerTitle: true,
      ),
      body: items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 130,
                          height: 90,
                          child: Image.asset(
                            'assets/images/${item.image}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => removeItem(item),
                          tooltip: 'Supprimer du panier',
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}