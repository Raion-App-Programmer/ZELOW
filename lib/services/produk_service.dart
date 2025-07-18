import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/services/toko_service.dart';
import '../models/produk_model.dart';

class ProdukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TokoServices _tokoService = TokoServices();

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

      // Ambil objek toko sekali saja
      final toko = await _tokoService.getTokoById(tokoId);

      List<Produk> produkList =
          snapshot.docs.map((doc) {
            final produk = Produk.fromFirestore(doc);
            if (toko != null) {
              return produk.copyWithToko(toko);
            }
            return produk;
          }).toList();

      return produkList;
    } catch (e) {
      print("Error saat mengambil produk by Id Toko: $e");
      return [];
    }
  }

  Future<List<Produk>> getProdukRandom({int limit = 10}) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('produk').get();

      print('Total produk ditemukan: ${snapshot.docs.length}');

      List<Produk> produkList = [];

      for (var doc in snapshot.docs) {
        final produk = Produk.fromFirestore(doc);

        // ambil data toko berdasarkan id_toko
        final toko = await _tokoService.getTokoById(produk.idToko);

        if (toko != null) {
          produkList.add(produk.copyWithToko(toko));
        } else {
          produkList.add(produk); // fallback
        }
      }

      produkList.shuffle(); // acak
      return produkList.take(limit).toList(); // batasi hasil
    } catch (e) {
      print('Error mengambil produk random: $e');
      return [];
    }
  }
}
