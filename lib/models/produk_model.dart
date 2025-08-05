import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/toko_model.dart';

class Produk {
  final String gambar;
  final double harga;
  final String idProduk;
  final String idToko;
  final int jumlahDisukai;
  final int jumlahPembelian;
  final String kategori;
  final String nama;
  final double rating;
  final int stok;
  final int terjual;
  final Toko? toko;
  final bool isFlashSale;
  final String deskripsi;

  Produk({
    required this.idProduk,
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
    required this.deskripsi,
    this.toko,
    this.isFlashSale = false,
  });

  factory Produk.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    double toDouble(dynamic value) {
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return 0.0; // fallback
    }

    return Produk(
      idProduk: doc.id,
      idToko: data['id_toko'] ?? '',
      kategori: data['kategori'] ?? '',
      nama: data['nama'] ?? '',
      gambar: data['gambar'] ?? '',
      harga: toDouble(data['harga']),
      rating: toDouble(data['rating']),
      jumlahPembelian: data['jumlah_pembelian'] ?? 0,
      jumlahDisukai: data['jumlah_disukai'] ?? 0,
      stok: data['stok'] ?? 0,
      terjual: data['terjual'] ?? 0,
      isFlashSale: false,
      deskripsi: data['deskripsi'] ?? '',
    );
  }

  Produk copyWith({
    String? idProduk,
    String? idToko,
    String? kategori,
    String? nama,
    String? gambar,
    double? harga,
    double? rating,
    int? jumlahPembelian,
    int? jumlahDisukai,
    int? stok,
    int? terjual,
    String? deskripsi,
    Toko? toko,
    bool? isFlashSale,
  }) {
    return Produk(
      idProduk: idProduk ?? this.idProduk,
      idToko: idToko ?? this.idToko,
      kategori: kategori ?? this.kategori,
      nama: nama ?? this.nama,
      gambar: gambar ?? this.gambar,
      harga: harga ?? this.harga,
      rating: rating ?? this.rating,
      jumlahPembelian: jumlahPembelian ?? this.jumlahPembelian,
      jumlahDisukai: jumlahDisukai ?? this.jumlahDisukai,
      stok: stok ?? this.stok,
      terjual: terjual ?? this.terjual,
      deskripsi: deskripsi ?? this.deskripsi,
      toko: toko ?? this.toko,
      isFlashSale: isFlashSale ?? this.isFlashSale,
    );
  }

  Produk copyWithToko(Toko tokoBaru) {
    return Produk(
      idProduk: idProduk,
      idToko: idToko,
      kategori: kategori,
      nama: nama,
      gambar: gambar,
      harga: harga,
      rating: rating,
      jumlahPembelian: jumlahPembelian,
      jumlahDisukai: jumlahDisukai,
      stok: stok,
      terjual: terjual,
      toko: tokoBaru,
      isFlashSale: isFlashSale,
      deskripsi: deskripsi,
    );
  }
}
