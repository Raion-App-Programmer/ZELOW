import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/keranjang_model.dart';
import 'package:zelow/models/produk_model.dart';

class KeranjangService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // ngambil id user yang sedang login
  String? get _userId => _auth.currentUser?.uid;

  // nambah atau update item di keranjang
  Future<void> addToCart(Produk produk, int quantity) async {
    if (quantity <= 0) return;
    try {
      final docRef = _firestore
          .collection('user')
          .doc(_userId)
          .collection('keranjang')
          .doc(produk.idProduk);
      
      // buat item keranjang baru
      final keranjangItem = KeranjangItem(produk: produk, quantity: quantity);

      // jika dokumen sudah ada, update quantity saja dengan menambah jumlahnya dengan quantity baru tapi jika belum ada, buat dokumen baru
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        // Jika sudah ada, update quantity (tambah dengan quantity baru)
        final currentQuantity = docSnapshot.data()?['quantity'] ?? 0;
        await docRef.update({
          'quantity': currentQuantity + quantity,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Jika belum ada, buat dokumen baru
        await docRef.set({
          ...keranjangItem.toFirestore(),
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Error menambah ke keranjang: $e");
    }
  }

  // buat ngambil semua item di keranjang
  Stream<List<KeranjangItem>> getCartItems() {
    return _firestore
    .collection('user')
    .doc(_userId)
    .collection('keranjang')
    .orderBy('timestamp', descending: true) // urutkan berdasarkan waktu
    .snapshots()
    .map((snapshot) {
      return snapshot.docs.map((doc) => KeranjangItem.fromFirestore(doc)).toList();
    });
  }

  // buat hapus item dari keranjang
  Future<void> removeFromCart(String produkId) async {
    try {
      await _firestore
          .collection('user')
          .doc(_userId)
          .collection('keranjang')
          .doc(produkId)
          .delete();
    } catch (e) {
      print("Error menghapus dari keranjang: $e");
    }
  }
}