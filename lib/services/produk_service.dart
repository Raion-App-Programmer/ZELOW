import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/produk_model.dart';

class ProdukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Produk>> getProdukByToko(String tokoId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('toko')
          .doc(tokoId)
          .collection('produk')
          .get();

      if (snapshot.docs.isEmpty) {
        print("Tidak ada produk ditemukan untuk toko dengan ID: $tokoId");
        return [];
      }

      List<Produk> produkList = snapshot.docs
          .map((doc) => Produk.fromFirestore(doc))
          .toList();
      return produkList;
    } catch (e) {
      print("Error saat mengambil produk: $e");
      return [];
    }
  }
}
