import 'package:cloud_firestore/cloud_firestore.dart';

class Toko {
  final String id;
  final String nama;
  final String gambar;
  final double rating;
  final num jarak;
  final String waktu;
  final int jumlahPenilaian;
  final String deskripsi;
  // final String alamat;

  const Toko({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.rating,
    required this.jarak,
    required this.waktu,
    required this.jumlahPenilaian,
    required this.deskripsi,
    // required this.alamat,
  });

  factory Toko.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Toko(
      id: doc.id,
      nama: data['nama'] ?? '',
      gambar: data['gambar'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      jarak: data['jarak'] ?? 0,
      waktu: data['waktu'] ?? '',
      jumlahPenilaian: data['jpenilaian'] ?? 0,
      deskripsi: data['deskripsi'] ?? '',
    );
  }
}
