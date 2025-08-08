import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/surprisebox_card.dart';
import 'package:zelow/pages/user/infoproduk_page.dart';

class SurpriseBoxPage extends StatelessWidget {
  final CollectionReference referenceProduk = FirebaseFirestore.instance
      .collection("produk");

  final CollectionReference referenceToko = FirebaseFirestore.instance
      .collection("toko");

  Future<Map<String, dynamic>> fetchTokoData(String tokoId) async {
    final tokoSnapshot = await referenceToko.doc(tokoId).get();
    if (tokoSnapshot.exists) {
      return {
        "distance": tokoSnapshot["jarak"],
        "estimatedTime": tokoSnapshot["waktu"],
      };
    }
    return {"distance": "", "estimatedTime": ""};
  }

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
                      "tokoId": e["id_toko"],
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
              final tokoId = product["tokoId"] ?? ""; // Pastikan field tokoId ada di koleksi produk

              return FutureBuilder<Map<String, dynamic>>(
                future: fetchTokoData(tokoId),
                builder: (context, tokoSnapshot) {
                  if (tokoSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }


                  final tokoData = tokoSnapshot.data ?? {"distance": "", "estimatedTime": ""};

                  return SurpirseCard(
                    imageUrl: product["imageUrl"],
                    restaurantName: product["restaurantName"],
                    description: "",
                    rating: product["rating"],
                    distance: tokoData["distance"].toString() + " km" ?? "-",
                    estimatedTime: tokoData["estimatedTime"] + " menit" ?? "-",
                    onTap: () {
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
