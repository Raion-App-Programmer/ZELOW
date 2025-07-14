import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String gambar;
  final int harga;
  final String id;
  final String idToko;
  final int jumlahDisukai;
  final int jumlahPembelian;
  final String kategori;
  final String nama;
  final double rating;
  final int stok;
  final int terjual;

  Produk({
    required this.id,
    required this.idToko,
    required this.kategori,
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.rating,
    required this.jumlahPembelian,
    required this.jumlahDisukai,
    required this.stok,
    required this.terjual,
  });

  factory Produk.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Produk(
      id: doc.id,
      idToko: data['id_toko'],
      kategori: data['kategori'],
      nama: data['nama'],
      gambar: data['gambar'],
      harga: data['harga'],
      rating: data['rating'],
      jumlahPembelian: data['jumlah_pembelian'],
      jumlahDisukai: data['jumlah_disukai'],
      stok: data['stok'],
      terjual: data['terjual'],
    );
  }
}