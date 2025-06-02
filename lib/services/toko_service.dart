import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/models/produk_model.dart';

class TokoServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _tokoCollection = 'toko';

  Future<List<Toko>> getTokoList({
    String? orderByField,
    bool isDecending = false,
    int? limit,
  }) async {
    Query query = _firestore.collection(_tokoCollection);

    if (orderByField != null) {
      query = query.orderBy(orderByField, descending: isDecending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) => Toko.fromFirestore(doc)).toList();
  }

  Future<List<Toko>> getTokoTerdekat({int limit = 5}) async {
    return getTokoList(orderByField: 'jarak', isDecending: false, limit: limit);
  }

  Future<List<Toko>> getTokoPalingLaris({int limit = 5}) async {
    return getTokoList(orderByField: 'rating', isDecending: true, limit: limit);
  }

  Future<List<Toko>> getAllTokoTerdekat({int limit = 5}) async {
    return getTokoList(orderByField: 'rating', isDecending: true);
  }

  Future<List<Toko>> getAllTokoPalingLaris({int limit = 5}) async {
    return getTokoList(orderByField: 'rating', isDecending: true);
  }

  Future<Toko?> getTokoById(String tokoId) async {
    DocumentSnapshot doc = await _firestore.collection(_tokoCollection)
        .doc(tokoId)
        .get();

    if (doc.exists) {
      return Toko.fromFirestore(doc);
    }
    return null;
  }

  Future<Toko?> getTokoRekomendasi() async {
    // Ambil beberapa (misal 5 acak berdasarkan ID) lalu pilih satu di client
    // Firestore tidak mendukung random query secara langsung dengan mudah.
    // Ini adalah pendekatan sederhana.
    QuerySnapshot snapshot = await _firestore.collection(_tokoCollection).limit(10).get(); // Ambil 10
    if (snapshot.docs.isNotEmpty) {
      final randomList = snapshot.docs..shuffle(); // Acak daftarnya
      return Toko.fromFirestore(randomList.first); // Ambil yang pertama setelah diacak
    }
    return null;
  }
}