import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/pages/user/toko_page.dart';
import 'package:zelow/services/toko_service.dart';

import '../../models/toko_model.dart';


class DisplayPage extends StatefulWidget {
  // Backend
  final String pageTitle;
  final String fetchType;

  const DisplayPage({
    Key? key,
    required this.pageTitle,
    required this.fetchType,
  });

  @override
  State<DisplayPage> createState() => _DisplayPageState();
  //
  // final List<Map<String, dynamic>> products = [
  //   {
  //     "imageUrl": "assets/images/naspad.jpg",
  //     "restaurantName": "Nasi Padang Spesial",
  //     "description": "Paket komplit dengan rendang dan sambal hijau",
  //     "rating": 4.9,
  //     "distance": "1 km",
  //     "estimatedTime": "10 min",
  //   },
  //   {
  //     "imageUrl": "assets/images/mie ayam.jpg",
  //     "restaurantName": "Mie Ayam Bakso",
  //     "description": "Mie kenyal dengan bakso besar",
  //     "rating": 4.7,
  //     "distance": "1.2 km",
  //     "estimatedTime": "12 min",
  //   },
  // ];
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: zelow, // Warna hijau untuk AppBar
  //       title: const Text(
  //         "Terkait",
  //         style: TextStyle(color: Colors.white), // Warna teks putih
  //       ),
  //       iconTheme: const IconThemeData(color: Colors.white), // Warna icon back putih
  //     ),
  //     body: ListView.builder(
  //       itemCount: products.length,
  //       itemBuilder: (context, index) {
  //         final product = products[index];
  //         return DisplayCard(
  //           imageUrl: product["imageUrl"],
  //           restaurantName: product["restaurantName"],
  //           description: product["description"],
  //           rating: product["rating"],
  //           distance: product["distance"],
  //           estimatedTime: product["estimatedTime"],
  //           onTap: () {
  //             print("${product["restaurantName"]} diklik!");
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}

class _DisplayPageState extends State<DisplayPage> {
  final TokoServices _tokoService = TokoServices();
  late Future<List<Toko>> _tokoList;

  @override
  void initState() {
    super.initState();
    _loadTokoList();
  }

  void _loadTokoList() {
    switch (widget.fetchType) {
      case "terdekat_full":
        _tokoList = _tokoService.getAllTokoTerdekat();
        break;
      case "paling_laris_full":
        _tokoList = _tokoService.getAllTokoPalingLaris();
        break;
      default:
      // Jika fetchType tidak dikenali, tampilkan daftar kosong atau error
        print("Error: fetchType tidak dikenali di DisplayPage - ${widget.fetchType}");
        _tokoList = Future.value([]); // Default list kosong
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow, // Warna AppBar
        title: Text(
          widget.pageTitle,
          style: const TextStyle(color: Colors.white), // Warna teks judul AppBar
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon kembali
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Toko>>(
        future: _tokoList,
        builder: (context, snapshot) {
          // Saat data sedang dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: zelow));
          }
          // Jika terjadi error
          if (snapshot.hasError) {
            print("Error di DisplayPage FutureBuilder (${widget.fetchType}): ${snapshot.error}");
            return Center(child: Text('Gagal memuat data toko.\nError: ${snapshot.error}'));
          }
          // Jika data tidak ada atau kosong
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada toko yang ditemukan untuk "${widget.pageTitle}".'));
          }

          // Jika data berhasil dimuat
          final tokoList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding untuk list
            itemCount: tokoList.length,
            itemBuilder: (context, index) {
              final toko = tokoList[index];
              // Menggunakan DisplayCard (product_card_horizontal.dart) untuk menampilkan setiap Toko
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0), // Jarak antar kartu
                child: DisplayCard(
                  imageUrl: toko.gambar,
                  restaurantName: toko.nama,
                  description: toko.deskripsi,
                  rating: toko.rating,
                  distance: '${toko.jarak} km',
                  estimatedTime: toko.waktu,
                  onTap: () {
                    // Navigasi ke halaman detail Toko (TokoPageUser)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TokoPageUser(tokoData: toko),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
