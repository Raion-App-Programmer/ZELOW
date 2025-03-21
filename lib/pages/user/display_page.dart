import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/product_card_horizontal.dart';


class DisplayPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "imageUrl": "assets/images/naspad.jpg",
      "restaurantName": "Nasi Padang Spesial",
      "description": "Paket komplit dengan rendang dan sambal hijau",
      "rating": 4.9,
      "distance": "1 km",
      "estimatedTime": "10 min",
    },
    {
      "imageUrl": "assets/images/mie ayam.jpg",
      "restaurantName": "Mie Ayam Bakso",
      "description": "Mie kenyal dengan bakso besar",
      "rating": 4.7,
      "distance": "1.2 km",
      "estimatedTime": "12 min",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow, // Warna hijau untuk AppBar
        title: const Text(
          "Terkait",
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Warna icon back putih
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return DisplayCard(
            imageUrl: product["imageUrl"],
            restaurantName: product["restaurantName"],
            description: product["description"],
            rating: product["rating"],
            distance: product["distance"],
            estimatedTime: product["estimatedTime"],
            onTap: () {
              print("${product["restaurantName"]} diklik!");
            },
          );
        },
      ),
    );
  }
}
