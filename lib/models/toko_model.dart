import 'package:cloud_firestore/cloud_firestore.dart';

class Toko {
  final String id;
  final String nama;
  final String gambar;
  final double rating;
  final num jarak; // Menggunakan num untuk fleksibilitas dari Firestore (bisa int/double)
  final String waktu;
  final int jumlahPenilaian; // Nama field di Firestore: jpenilaian
  final String deskripsi;

  const Toko({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.rating,
    required this.jarak,
    required this.waktu,
    required this.jumlahPenilaian,
    required this.deskripsi,
  });

  factory Toko.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Toko(
      id: doc.id,
      nama: data['nama'],
      gambar: data['gambar'],
      rating: data['rating'],
      jarak: data['jarak'],
      waktu: data['waktu'],
      jumlahPenilaian: data['jpenilaian'],
      deskripsi: data['deskripsi'],
    );
  }
}