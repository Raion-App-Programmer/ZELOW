import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';

class FlashSaleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // mendapatkan produk flash sale berdasarkan indeks waktu
  Future<List<Produk>> getFlashSaleProdukByTime(int targetIndex) async {
    final tokoSnapshot = await _firestore.collection('toko').get();
    List<Produk> result = [];

    for (var tokoDoc in tokoSnapshot.docs) {
      final tokoData = Toko.fromFirestore(tokoDoc);

      final produkSnapshot =
          await _firestore
              .collection('produk')
              .where('id_toko', isEqualTo: tokoDoc.id)
              .where('kategori', isEqualTo: 'makanan')
              .get();

      final produkList =
          produkSnapshot.docs.map((doc) => Produk.fromFirestore(doc)).toList();

      if (produkList.length > targetIndex) {
        final produkDenganToko = produkList[targetIndex].copyWithToko(tokoData);
        result.add(produkDenganToko);
      }
    }

    return result;
  }
}
