import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/surprisebox_card.dart';
import 'package:zelow/pages/user/infoproduk_page.dart';

class SurpriseBoxPage extends StatelessWidget {
  final CollectionReference referenceProduk = FirebaseFirestore.instance
      .collection("produk");

  final CollectionReference referenceToko = FirebaseFirestore.instance
      .collection("toko");

  Future<Toko?> fetchTokoData(String tokoId) async {
    if (tokoId.isEmpty) return null;

    final tokoSnapshot = await referenceToko.doc(tokoId).get();
    if (tokoSnapshot.exists) {
      return Toko.fromFirestore(tokoSnapshot);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchProdukDanToko() async {
    final produkSnapshot = await referenceProduk.limit(10).get();
    final List<Produk> produkList =
        produkSnapshot.docs.map((doc) => Produk.fromFirestore(doc)).toList();

    List<Map<String, dynamic>> result = [];
    for (var produk in produkList) {
      final toko = await fetchTokoData(produk.idToko);
      if (toko != null) {
        result.add({'produk': produk, 'toko': toko});
      }
    }
    result.shuffle();
    return result;
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
        title: const Text(
          'Surprise Box',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProdukDanToko(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada data"));
          }

          final items = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index]['produk'] as Produk;
              final toko = items[index]['toko'] as Toko;

              return SurpriseCard(
                productData: product,
                tokoData: toko,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProductInfoPage(
                            productData: product,
                            tokoData: toko,
                          ),
                    ),
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
