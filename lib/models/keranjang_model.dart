import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';

class KeranjangModel {
  final Produk produk;
  final int quantity;
  final Toko? toko;

  KeranjangModel({required this.produk, required this.quantity, this.toko});

  factory KeranjangModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return KeranjangModel(
      produk: Produk(
        gambar: data['gambar'],
        harga: data['harga'],
        idToko: data['id_toko'],
        jumlahDisukai: data['jumlah_disukai'],
        jumlahPembelian: data['jumlah_pembelian'],
        kategori: data['kategori'],
        idProduk: doc.id,
        nama: data['nama'],
        rating: data['rating'],
        stok: data['stok'],
        terjual: data['terjual'],
        deskripsi: data['deskripsi'],
      ),
      quantity: data['quantity'],
      toko: null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id_produk': produk.idProduk,
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
      'deskripsi': produk.deskripsi,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
