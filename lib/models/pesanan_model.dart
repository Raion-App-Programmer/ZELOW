import 'package:cloud_firestore/cloud_firestore.dart';

class Pesanan {
  final String idPesanan;
  final double hargaSatuan;
  final String metodePembayaran;
  final String status;
  final Timestamp waktuPesan;
  final int quantity;
  final String idToko;
  final String alamatToko;
  final String? idUser;
  final String idProduk;
  final String namaProduk;
  final String jadwalPengambilan;
  final String gambarProduk;

  Pesanan({
    required this.idPesanan,
    required this.hargaSatuan,
    required this.metodePembayaran,
    required this.status,
    required this.waktuPesan,
    required this.quantity,
    required this.idToko,
    required this.idUser,
    required this.idProduk,
    required this.jadwalPengambilan,
    required this.alamatToko,
    required this.namaProduk,
    required this.gambarProduk,
  });

  factory Pesanan.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pesanan(
      idPesanan: doc.id,
      hargaSatuan: data['harga_satuan'],
      metodePembayaran: data['metode_pembayaran'],
      status: data['status'],
      alamatToko: data['alamat_toko'],
      namaProduk: data['nama_produk'],
      waktuPesan: data['waktu_pesan'],
      quantity: data['quantity'],
      idToko: data['id_toko'],
      idUser: data['id_user'],
      idProduk: data['id_produk'],
      jadwalPengambilan: data['jadwal_pengambilan'],
      gambarProduk: data['gambar_produk'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id_pesanan': idPesanan,
      'harga_satuan': hargaSatuan,
      'metode_pembayaran': metodePembayaran,
      'status': status,
      'waktu_pesan': waktuPesan,
      'quantity': quantity,
      'id_toko': idToko,
      'id_user': idUser,
      'id_produk': idProduk,
      'jadwal_pengambilan': jadwalPengambilan,
      'alamat_toko': alamatToko,
      'nama_produk': namaProduk,
      'gambar_produk': gambarProduk,
    };
  }
}
