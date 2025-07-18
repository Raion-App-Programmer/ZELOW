import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/produk_model.dart';

class ProdukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Produk>> getProdukByToko(String tokoId) async {
    try {
      QuerySnapshot snapshot =
          await _firestore
              .collection('produk')
              .where('id_toko', isEqualTo: tokoId)
              .get();

      if (snapshot.docs.isEmpty) {
        print("Tidak ada produk ditemukan untuk toko dengan ID: $tokoId");

        return [];
      }

      List<Produk> produkList =
          snapshot.docs.map((doc) => Produk.fromFirestore(doc)).toList();

      return produkList;
    } catch (e) {
      print("Error saat mengambil produk by Id Toko: $e");
      return [];
    }
  }

  // fungsi untuk mengambil alamat toko produk
  Future<String> getAlamatTokoByProdukId(String tokoId) async {
    final alamatTokoProduk =
        (await _firestore.collection('toko').doc(tokoId).get())
            .data()?['alamat'];

    return alamatTokoProduk;
  }

  Future<List<Produk>> getProdukRandom({int limit = 10}) async {
    try {
      QuerySnapshot snapshot =
          await _firestore
              .collection('produk') // karena kamu pakai struktur: produk > uid
              .get();

      print('Total produk ditemukan: ${snapshot.docs.length}');

      List<Produk> produkList =
          snapshot.docs.map((doc) => Produk.fromFirestore(doc)).toList();

      produkList.shuffle(); // acak
      return produkList.take(limit).toList(); // batasi hasil
    } catch (e) {
      print('Error mengambil produk random: $e');
      return [];
    }
  }
}
