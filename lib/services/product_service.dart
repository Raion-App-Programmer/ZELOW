import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart'; // pastikan path sesuai

class ProdukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProdukRandom({int limit = 10}) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('produk') // karena kamu pakai struktur: produk > uid
          .get();

      print('Total produk ditemukan: ${snapshot.docs.length}');

      List<Product> produkList = snapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();

      produkList.shuffle(); // acak
      return produkList.take(limit).toList(); // batasi hasil
    } catch (e) {
      print('Error mengambil produk: $e');
      return [];
    }
  }
}
