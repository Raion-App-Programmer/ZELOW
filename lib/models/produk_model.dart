import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String idProduk;
  final String idToko;
  final String namaKategori;
  final String nama;
  final String urlGambar;
  final int harga;
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

  factory Produk.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Produk(
      idProduk: doc.id,
      idToko: data['id_toko'] ?? '',
      namaKategori: data['nama_kategori'] ?? '',
      nama: data['nama'] ?? 'Nama Produk Tidak Tersedia',
      urlGambar: data['url_gambar'] ?? 'https://picsum.photos/200/200',
      harga: (data['harga'] as num?)?.toInt() ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      jumlahTerjual: data['jumlah_terjual'] ?? 0,
      jumlahSuka: data['jumlah_suka'] ?? 0,
    );
  }
}