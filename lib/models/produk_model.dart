import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String id;
  final String nama; // Nama item produk di dalam toko
  final String deskripsi;
  final String gambar;
  final double harga; // Harga item produk
  final double rating; // Rating spesifik item produk (jika ada)
  final int jumlahPenilaian; // Jumlah penilaian spesifik item produk (jika ada)

  Produk({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.rating,
    required this.jumlahPenilaian,
  });

  factory Produk.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Produk(
      id: doc.id,
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      gambar: data['gambar'],
      harga: data['harga'],
      rating: data['rating'],
      jumlahPenilaian: data['jpenilaian'],
    );
  }
}