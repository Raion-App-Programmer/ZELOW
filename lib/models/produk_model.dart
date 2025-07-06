import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String nama;
  final String gambar;
  final double harga;
  final double rating;
  final int jumlahDisukai;
  final int jumlahPembelian;
  final String kategori;
  final String idToko;
  final int kuantitas;
  bool isSelected;

  Product({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.rating,
    required this.jumlahDisukai,
    required this.jumlahPembelian,
    required this.kategori,
    required this.idToko,
    required this.kuantitas,
    this.isSelected = false,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      nama: data['nama'] ?? '',
      gambar: data['gambar'] ?? '',
      harga: (data['harga'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      jumlahDisukai: data['jumlah_disukai'] ?? 0,
      jumlahPembelian: data['jumlah_pembelian'] ?? 0,
      kategori: data['kategori'] ?? '',
      idToko: data['id_toko'] ?? '',
      kuantitas: data['kuantitas'] ?? 0,
    );
  }
}
