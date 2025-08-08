import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/surprisebox_card.dart';

class SurpriseBoxPage extends StatelessWidget {
  final CollectionReference referenceProduk = FirebaseFirestore.instance
      .collection("produk");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Surprise Box',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: white,
      body: StreamBuilder<QuerySnapshot>(
        stream: referenceProduk.snapshots(),
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
                      // "description": e["deskripsi"],
                      "rating": e["rating"],
                      // "distance": e["jarak"],
                      // "estimatedTime": e["waktu"],
                    },
                  )
                  .toList();

          items.shuffle();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return SurpirseCard(
                imageUrl: product["imageUrl"],
                restaurantName: product["restaurantName"],
                description: "",
                rating: product["rating"],
                distance: "",
                estimatedTime: "",
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
