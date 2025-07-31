import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/toko_model.dart';

import '../models/produk_model.dart';


class TokoServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final String _tokoCollection = 'toko';
  final String _userCollection = 'user';

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

  Future<List<Toko>> getAllTokoTerdekat() async {
    return getTokoList(orderByField: 'jarak', isDecending: false);
  }


  Future<List<Toko>> getAllTokoPalingLaris() async {
    return getTokoList(orderByField: 'rating', isDecending: true);
  }

  Future<List<Toko>> getAllTokoRandom() async {
    QuerySnapshot querySnapshot = await _firestore.collection(_tokoCollection).get();
    List<Toko> tokoList = querySnapshot.docs.map((doc) => Toko.fromFirestore(doc)).toList();
    tokoList.shuffle();
    return tokoList;
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

  Future<String?> getUserRole() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return null;
    }

    final doc = await _firestore.collection(_userCollection).doc(uid).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return data['role'];
    }
    return null;

  }

  Future<String?> getIDToko() async {
    User? user = _auth.currentUser;

    String? userID = user?.uid;
    try {
      DocumentSnapshot tokoDoc = await _firestore
          .collection(_tokoCollection)
          .doc(userID)
          .get();

      return tokoDoc.id;
    } catch (e) {

    }


  }

  Future<Toko?> getTokoByUserID() async {
    String? tokoID = await getIDToko();
    if(tokoID == null){
      return null;
    }
    return await getTokoById(tokoID);
  }

  Stream<List<Produk>> getProdukItem(){
    return _firestore
        .collection('produk')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Produk.fromFirestore(doc)).toList();
    });
  }

  Future<void> tokoUMKM(Toko toko) async {
    User? currentUser = _auth.currentUser;
    String? userUMKMID = currentUser?.uid;
    try {
      final docRef = await _firestore
          .collection(_tokoCollection)
          .doc(userUMKMID);

      final Map<String, dynamic>tokoData = {
        'id': userUMKMID,
        'nama': toko.nama,
        'gambar': toko.gambar,
        'rating': toko.rating,
        'jarak': toko.jarak,
        'waktu': toko.waktu,
        'jpenilaian': toko.jumlahPenilaian,
        'deskripsi': toko.deskripsi,
      };

      final docSnapShot = await docRef.get();
      if (docSnapShot.exists) {
        await docRef.update(tokoData);
      } else {
        await docRef.set(tokoData);
      }

    } catch (e) {
      print('Error adding toko: $e');
    }
  }
}