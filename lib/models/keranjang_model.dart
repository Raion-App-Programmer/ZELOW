import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/models/produk_model.dart';

class KeranjangItem {
  final Produk produk;
  final int quantity;

  KeranjangItem({
    required this.produk,
    required this.quantity,
  });

  factory KeranjangItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return KeranjangItem(
      produk: Produk(
        idProduk: doc.id,
        idToko: data['id_toko'] ?? '',
        namaKategori: data['nama_kategori'] ?? '',
        nama: data['nama'] ?? 'Produk tidak tersedia',
        urlGambar: data['url_gambar'] ?? '',
        harga: (data['harga'] as num?)?.toInt() ?? 0,
        rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
        jumlahTerjual: data['jumlah_terjual'] ?? 0,
        jumlahSuka: data['jumlah_suka'] ?? 0,
      ),
      quantity: data['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id_toko': produk.idToko,
      'nama_kategori': produk.namaKategori,
      'nama': produk.nama,
      'url_gambar': produk.urlGambar,
      'harga': produk.harga,
      'rating': produk.rating,
      'jumlah_terjual': produk.jumlahTerjual,
      'jumlah_suka': produk.jumlahSuka,
      'quantity': quantity,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}