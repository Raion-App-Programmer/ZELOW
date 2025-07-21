import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart';

class KeranjangItem {
  final Produk produk;
  final int quantity;

  KeranjangItem({required this.produk, required this.quantity});

  factory KeranjangItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return KeranjangItem(
      produk: Produk(
        harga: data['harga'],
        idToko: data['id_toko'],
        jumlahDisukai: data['jumlah_disukai'],
        jumlahPembelian: data['jumlah_pembelian'],
        kategori: data['kategori'],
        id: doc.id,
        nama: data['nama'],
        gambar: data['gambar'],
        rating: data['rating'],
        stok: data['stok'],
        terjual: data['terjual'],
        deskripsi: data['deskripsi']
      ),
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': produk.id,
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
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
