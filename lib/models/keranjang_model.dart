import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart';

class KeranjangModel {
  final Produk produk;
  final int quantity;
  final String alamat;

  KeranjangModel({
    required this.produk,
    required this.quantity,
    required this.alamat,
  });

  factory KeranjangModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return KeranjangModel(
      produk: Produk(
        harga: data['harga'],
        idToko: data['id_toko'],
        jumlahDisukai: data['jumlah_disukai'],
        jumlahPembelian: data['jumlah_pembelian'],
        kategori: data['kategori'],
        idProduk: doc.id,
        nama: data['nama'],
        gambar: data['gambar'],
        rating: data['rating'],
        stok: data['stok'],
        terjual: data['terjual'],
      ),
      quantity: data['quantity'],
      alamat: data['alamat'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': produk.idProduk,
      'id_toko': produk.idToko,
      'kategori': produk.kategori,
      'nama': produk.nama,
      'gambar': produk.gambar,
      'harga': produk.harga,
      'rating': produk.rating,
      'jumlah_pembelian': produk.jumlahPembelian,
      'jumlah_disukai': produk.jumlahDisukai,
      'stok': produk.stok,
      'terjual': produk.terjual,
      'quantity': quantity,
      'alamat': alamat,
      'timestamp': FieldValue.serverTimestamp(), // Untuk mengurutkan item di keranjang berdasarkan waktu
    };
  }
}
