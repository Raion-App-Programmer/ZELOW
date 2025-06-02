import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/product_card_horizontal.dart';

class RekomendasiPage extends StatelessWidget {
  final CollectionReference referenceToko = FirebaseFirestore.instance
      .collection("toko");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow, // Warna hijau untuk AppBar
        title: const Text(
          "Rekomendasi",
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Warna icon back putih
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: referenceToko.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Tidak ada data"));
          }
          final items =
              snapshot.data!.docs
                  .map(
                    (e) => {
                      "imageUrl": e["gambar"],
                      "restaurantName": e["nama"],
                      "description": e["deskripsi"],
                      "rating": e["rating"],
                      "distance": e["jarak"],
                      "estimatedTime": e["waktu"],
                    },
                  )
                  .toList();

          items.shuffle();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return DisplayCard(
                imageUrl: product["imageUrl"],
                restaurantName: product["restaurantName"],
                description: product["description"],
                rating: product["rating"],
                distance: product["distance"].toString(),
                estimatedTime: product["estimatedTime"],
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
