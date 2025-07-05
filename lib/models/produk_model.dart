import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String idProduk;
  final String idToko;
  final String namaKategori;
  final String nama;
  final String urlGambar;
  final double harga;
  final double rating;
  final int jumlahTerjual;
  final int jumlahSuka;

  Produk({
    required this.idProduk,
    required this.idToko,
    required this.namaKategori,
    required this.nama,
    required this.urlGambar,
    required this.harga,
    required this.rating,
    required this.jumlahTerjual,
    required this.jumlahSuka,
  });
}