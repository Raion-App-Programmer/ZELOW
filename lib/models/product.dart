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
}
