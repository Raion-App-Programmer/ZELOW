import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/models/pesanan_model.dart';

class PesananService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _idUser = FirebaseAuth.instance.currentUser?.uid;

  // fungsi untuk menambahkan pesanan ke firestore
  // sebelum dikirim ke firestore, datanya akan dikelompokkan terlebih dahulu berdasarkan tokonya (ngikut desain figma)
  Future<void> addPesanan(
    List<Map<String, dynamic>> listOrder, // datanya berisi list map dengan key String dan value dynamic
    String metodePembayaran, // ini tersendiri karena ini itu data baru yang dipilih user di halaman checkout
  ) async {

    // ini variabel hasil pengelompokan datanya
    final Map<String, List<Map<String, dynamic>>> pesananByToko = {}; 

    // proses pengelompokan dengan loop untuk ngefilter produk-produk yang berbeda tokonya
    for (var pesanan in listOrder) {
      // pertama ambil dulu id dari loop pertama
      String idToko = pesanan['idToko'];

      // jika variabel pesananByToko belum punya key idToko produk, maka tambahkan key dengan value kosong
      if (!pesananByToko.containsKey(idToko)) {
        pesananByToko[idToko] = [];
      }

      // tambahkan produk pesanan loop sekarang ke variabel pesananByToko
      // Prosesnya ini akan terus berulang
      pesananByToko[idToko]!.add(pesanan);

      /* Misalnya ada 5 produk yang di checkout
      1. Es teh       => id toko: 123
      2. Ayam Goreng  => id toko: 123
      3. Sate         => id toko: 456
      4. Jus Alpukat  => id toko: 123
      5. Perkedel     => id toko: 456

      Setelah di proses dan dimasukkan ke variabel pesananByToko, hasilnya adalah:
      id toko: 123 {Es teh, Ayam Goreng, Jus Alpukat} 
      id toko: 456 {Sate, Perkedel}

      Meskipun di checkout bersamaan, id pesanan keduanya akan beda
      karena di figma, 1 id pesanan untuk 1 toko aja dan 1 id pesanan bisa
      diisikan banyak produk.

      Tapi meskipun dikelompokkan kayak gini, di firestore datanya ga berkelompok
      Kenapa? agar mudah di fetch sekaligus dari dalam satu collection.

      Yang buat berkelompok itu adalah idPesanan. idPesanan akan sama kalo dia satu toko
      */
    } 

    // buat batch firestore biar sekali panggil langsung bisa upload banyak data
    final WriteBatch batch = _firestore.batch(); 

    // iterasi pertama untuk semua key di map pesananByToko
    pesananByToko.forEach((idToko, daftarPesanan) {

      // kita buat id pesanan yang sama untuk semua produk yang tokonya sama
      final String idPesanan = _firestore.collection('temp').doc().id;

      // iterasi kedua untuk value nya
      for (var pesanan in daftarPesanan) {
        // kita buat referensi lokasinya di firestore yaitu di dalam collection pesanan
        final idDocument = _firestore.collection('pesanan').doc();

        // buat objek Pesanan dari class Pesanan
        final Pesanan pesananBaru = Pesanan(
          idPesanan: idPesanan,
          harga: pesanan['harga'],
          metodePembayaran: metodePembayaran,
          status: 'berlangsung',
          waktuPesan: Timestamp.now(),
          quantity: pesanan['quantity'],
          idToko: idToko,
          idUser: _idUser,
          idProduk: pesanan['idProduk'],
        );

        // masukkan referensi lokasi dan objeck pesanan tadi ke batch firestore
        batch.set(idDocument, pesananBaru.toFirestore());
      }
    });

    try {
      // seluruh batch di kirim ke firestore
      await batch.commit(); 

      // abaikan aja ini, buat debugging
      print("${pesananByToko.length} pesanan berhasil ditambahkan ");
    } catch (e) {
      print('Error menambahkan pesanan: $e');
    }
  }

  Stream<List<Pesanan>> getPesananUser() {
    return _firestore
        .collection('pesanan')
        // .orderBy('timestamp', descending: true)
        .where('id_user', isEqualTo: _idUser)
        .snapshots()
        .map((snapshot) {
          print('Pesanan ditemukan sebanyak ${snapshot.docs.length} dokumen.');
          return snapshot.docs.map((doc) => Pesanan.fromFirestore(doc)).toList();
    });
  }

  Stream<List<Pesanan>> getPesananToko(String idToko) {
    return _firestore
        .collection('pesanan')
        .where('id_toko', isEqualTo: idToko)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Pesanan.fromFirestore(doc)).toList(),
        );
  }

  // Fungsi untuk mengupdate status pesanan
  Future<void> updateStatusPesanan(String idPesanan, String statusBaru) async {
    try {
      await _firestore.collection('pesanan').doc(idPesanan).update({
        'status': statusBaru,
      });

      print("Status pesanan $idPesanan berhasil diupdate ke $statusBaru");
    } catch (e) {
      print("Error mengupdate status pesanan: $e");
    }
  }
}
