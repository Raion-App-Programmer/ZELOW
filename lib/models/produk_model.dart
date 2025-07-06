import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String id;
  final String nama;
  final String gambar;
  final double harga;
  final double rating;
  final int jumlahPembelian;

  Produk({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.rating,
    required this.jumlahPembelian,
  });

  factory Produk.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Produk(
      id: doc.id,
      nama: data['nama'] ?? 'Tanpa Nama',
      gambar: data['gambar'] ?? '',
      harga: (data['harga'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      jumlahPembelian: data['jumlah_pembelian'] ?? 0,
    );
  }
}
