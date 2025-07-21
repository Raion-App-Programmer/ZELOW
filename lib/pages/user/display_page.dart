import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:zelow/pages/user/toko_page.dart';
import 'package:zelow/services/toko_service.dart';
import '../../models/toko_model.dart';

class DisplayPage extends StatefulWidget {
  final String pageTitle;
  final String fetchType;

  const DisplayPage({
    Key? key,
    required this.pageTitle,
    required this.fetchType,
  });

  @override
  State<DisplayPage> createState() => _DisplayPageState();
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
        print("Error: fetchType tidak dikenali - ${widget.fetchType}");
        _tokoList = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: zelow,
        title: Text(
          widget.pageTitle,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Toko>>(
        future: _tokoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: zelow));
          }

          if (snapshot.hasError) {
            print("Error di DisplayPage FutureBuilder: ${snapshot.error}");
            return Center(
              child: Text(
                'Gagal memuat data toko.\nError: ${snapshot.error}',
                style: const TextStyle(fontFamily: 'Nunito'),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada toko yang ditemukan untuk "${widget.pageTitle}".',
                style: const TextStyle(fontFamily: 'Nunito'),
              ),
            );
          }

          final tokoList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
            itemCount: tokoList.length,
            itemBuilder: (context, index) {
              final toko = tokoList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: DisplayCard(
                  imageUrl: toko.gambar,
                  restaurantName: toko.nama,
                  description: toko.deskripsi,
                  rating: toko.rating,
                  distance: '${toko.jarak} km',
                  estimatedTime: toko.waktu,
                  onTap: () {
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
