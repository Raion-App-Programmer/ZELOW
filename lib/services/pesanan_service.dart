import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/pesanan_model.dart';

class PesananService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> addPesanan(Pesanan pesanan) async {
    try {
      if (userId == null) {
        print("User tidak ditemukan, tidak bisa menambahkan pesanan.");
        return;
      }

      // Simpan pesanan ke Firestore
      await _firestore.collection('pesanan').add(pesanan.toFirestore());

      print("Pesanan berhasil ditambahkan: ${pesanan.idPesanan}");
    } catch (e) {
      print('Error menambahkan pesanan: $e');
    }
  }

  Stream<List<Pesanan>> getAllPesanan() {
    if (userId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('pesanan')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Pesanan.fromFirestore(doc)).toList(),
        );
  }

  // Fungsi untuk mengupdate status pesanan
  Future<void> updateStatusPesanan(String pesananId, String status) async {
    if (userId == null) {
      print("User tidak ditemukan, tidak bisa mengupdate status pesanan.");
      return;
    }

    try {
      await _firestore.collection('pesanan').doc(pesananId).update({
        'status': status,
      });

      print("Status pesanan $pesananId berhasil diupdate ke $status");
    } catch (e) {
      print("Error mengupdate status pesanan: $e");
    }
  }
}
