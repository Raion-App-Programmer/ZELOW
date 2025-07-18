import 'package:cloud_firestore/cloud_firestore.dart';

class Pesanan {
  final String idPesanan;
  final double totalHarga;
  final String metodePembayaran;
  final String status;
  final Timestamp waktuPesan;
  final int quantity;
  final String idToko;
  final String idUser;
  final List<String> listIdProduk;

  Pesanan({
    required this.idPesanan,
    required this.totalHarga,
    required this.metodePembayaran,
    required this.status,
    required this.waktuPesan,
    required this.quantity,
    required this.idToko,
    required this.idUser,
    required this.listIdProduk,
  });

  factory Pesanan.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pesanan(
      idPesanan: doc.id,
      totalHarga: data['total_harga'],
      metodePembayaran: data['metode_pembayaran'],
      status: data['status'],
      waktuPesan: data['waktu_pesan'],
      quantity: data['quantity'],
      idToko: data['id_toko'],
      idUser: data['id_user'],
      listIdProduk: List<String>.from(data['list_id_produk']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'total_harga': totalHarga,
      'metode_pembayaran': metodePembayaran,
      'status': status,
      'waktu_pesan': waktuPesan,
      'quantity': quantity,
      'id_toko': idToko,
      'id_produk': listIdProduk,
      'id_user': idUser,
      'timestamp': FieldValue.serverTimestamp(), // Untuk mengurutkan pesanan berdasarkan waktu
    };
  }
}