import 'package:flutter/material.dart';
import 'package:workshop_flutter__4ei3/CardFilmItem.dart';
import 'package:workshop_flutter__4ei3/Cart.dart';
import 'package:workshop_flutter__4ei3/FilmDetailPage.dart';

class GStore extends StatefulWidget {
  const GStore({super.key});

  @override
  State<GStore> createState() => _GStoreState();
}

class _GStoreState extends State<GStore> {
  final List<CartItem> cartItems = [];

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          items: cartItems,
          onRemove: (item) => setState(() => cartItems.remove(item)),
        ),
      ),
    );
  }

  void openFilm({
    required String image,
    required String title,
    required String description,
    required int price,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilmDetailPage(
          image: image,
          title: title,
          description: description,
          price: price,
          onBuy: () {
            setState(() {
              cartItems.add(
                CartItem(image: image, title: title, price: price),
              );
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Film ajouté au panier')),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("G-STORE"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: openCart,
            tooltip: 'Ouvrir le panier',
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            CardFilmItem(
              image: 'iceroad.jpg',
              title: 'Ice Road',
              onTap: () => openFilm(
                image: 'iceroad.jpg',
                title: 'Ice Road',
                description: 'Un film d’action et d’aventure.',
                price: 250,
              ),
            ),
            CardFilmItem(
              image: 'thegrudge.jpg',
              title: 'The Grudge',
              onTap: () => openFilm(
                image: 'thegrudge.jpg',
                title: 'The Grudge',
                description: 'Une histoire terrifiante pleine de suspense.',
                price: 280,
              ),
            ),
            CardFilmItem(
              image: 'HouseOfDead.jpg',
              title: 'House Of Dead',
              onTap: () => openFilm(
                image: 'HouseOfDead.jpg',
                title: 'House Of Dead',
                description:
                    'The House of the Dead et son remake de 2022 prennent place en 1998, alors que les agents AMS Thomas Rogan et G attaquent la demeure du Dr. Curien, un ingénieur génétique devenu fou qui a libéré des créatures sur sa propre équipe.',
                price: 300,
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}