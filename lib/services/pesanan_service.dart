import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/pesanan_model.dart';

class PesananService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? idUser = FirebaseAuth.instance.currentUser?.uid;

  Future<void> addPesanan(Pesanan pesanan) async {
    try {
      if (idUser == null) {
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

  Stream<List<Pesanan>> getPesananByIdUser() {
    return _firestore
        .collection('pesanan')
        .where('id_user', isEqualTo: idUser)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Pesanan.fromFirestore(doc)).toList(),
        );
  }

  Stream<List<Pesanan>> getPesananByIdToko (String idToko) {
    return _firestore
        .collection('pesanan')
        .where('id_toko', isEqualTo: idToko)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Pesanan.fromFirestore(doc)).toList(),
        );
  }

  // Fungsi untuk mengupdate status pesanan
  Future<void> updateStatusPesanan(String pesananId, String status) async {
    if (idUser == null) {
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
