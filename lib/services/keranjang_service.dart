import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/keranjang_model.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart'; // pastikan import model Toko

class KeranjangService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  // nambah atau update item di keranjang
  Future<void> addToCart(Produk produk, int quantity) async {
    try {
      final tokoDoc =
          await _firestore.collection('toko').doc(produk.idToko).get();

      if (!tokoDoc.exists || tokoDoc.data() == null) {
        log("Toko dengan id ${produk.idToko} tidak ditemukan");
        return;
      }

      final toko = Toko.fromMap({'id': tokoDoc.id, ...tokoDoc.data()!});

      final docRef = _firestore
          .collection('user')
          .doc(_userId)
          .collection('keranjang')
          .doc(produk.idProduk);

      final keranjangItem = KeranjangModel(
        produk: produk,
        quantity: quantity,
        toko: toko,
      );

      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final currentQuantity = docSnapshot.data()?['quantity'] ?? 0;
        await docRef.update({
          'quantity': currentQuantity + quantity,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        await docRef.set({
          ...keranjangItem.toFirestore(),
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      log("Error menambah ke keranjang: $e");
    }
  }

  // buat ngambil semua item di keranjang
  Stream<List<KeranjangModel>> getCartItems() {
    return _firestore
        .collection('user')
        .doc(_userId)
        .collection('keranjang')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          final items = <KeranjangModel>[];
          for (var doc in snapshot.docs) {
            var keranjang = KeranjangModel.fromFirestore(doc);

            // ambil detail toko
            final tokoDoc =
                await _firestore
                    .collection('toko')
                    .doc(keranjang.produk.idToko)
                    .get();
            if (tokoDoc.exists) {
              keranjang = KeranjangModel(
                produk: keranjang.produk,
                quantity: keranjang.quantity,
                toko: Toko.fromMap({'id': tokoDoc.id, ...tokoDoc.data()!}),
              );
            }

            items.add(keranjang);
          }
          return items;
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
      log("Error menghapus dari keranjang: $e");
    }
  }
}
