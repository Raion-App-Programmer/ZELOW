import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';

class FlashSaleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan 1 produk flash sale per toko untuk slot waktu tertentu
  Future<List<Produk>> getFlashSaleProdukByTime(int targetIndex) async {
    List<Produk> result = [];

    try {
      final tokoSnapshot = await _firestore.collection('toko').get();

      for (var tokoDoc in tokoSnapshot.docs) {
        final tokoData = Toko.fromFirestore(tokoDoc);

        final produkSnapshot =
            await _firestore
                .collection('produk')
                .where('id_toko', isEqualTo: tokoDoc.id)
                .where('kategori', isEqualTo: 'makanan')
                .get();

        final produkList =
            produkSnapshot.docs
                .map((doc) => Produk.fromFirestore(doc).copyWithToko(tokoData))
                .toList();

        // Cek apakah ada produk dengan index targetIndex
        if (produkList.length > targetIndex) {
          result.add(produkList[targetIndex]);
        } else if (produkList.isNotEmpty) {
          result.add(produkList.first);
        }
      }
    } catch (e) {
      print('Error mengambil data flash sale: $e');
    }

    return result;
  }
}
