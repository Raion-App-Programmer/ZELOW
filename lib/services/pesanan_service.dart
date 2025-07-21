import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/pesanan_model.dart';

class PesananService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  Future<void> createPesanan({
    required List<Map<String, dynamic>> items,
    required double totalPrice,
    required double serviceFee,
  }) async {
    
    final docRef = _firestore
        .collection('user')
        .doc(_userId)
        .collection('checkout')
        .doc();

    final orderData = {
      'items': items,
      'totalPrice': totalPrice,
      'serviceFee': serviceFee,
      'status': 'Berlangsung',
      'orderDate': Timestamp.now(),
      'userId': _userId,
      'orderNumber': DateTime.now().millisecondsSinceEpoch,
    };

    await docRef.set(orderData);

    final keranjangCollection = _firestore
        .collection('user')
        .doc(_userId)
        .collection('keranjang');

    WriteBatch batch = _firestore.batch();
    for (var item in items) {
      if (item['idProduk'] != null) {
        batch.delete(keranjangCollection.doc(item['idProduk']));
      }
    }
    await batch.commit();
  }

  Stream<List<Pesanan>> getPesanan() {
    if (_userId == null) return Stream.value([]);
    
    return _firestore
        .collection('user')
        .doc(_userId)
        .collection('checkout')
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) {
      try {
        return snapshot.docs.map((doc) => Pesanan.fromFirestore(doc)).toList();
      } catch (e) {
        print("Error parsing pesanan: $e");
        return [];
      }
    });
  }
}