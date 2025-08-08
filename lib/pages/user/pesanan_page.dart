import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zelow/components/berlangsung_card.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/selesai_card.dart';
import 'package:zelow/components/batal_card.dart';
import 'package:zelow/models/pesanan_model.dart';
import 'package:zelow/services/pesanan_service.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({super.key});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final PesananService _pesananService = PesananService();

  int _selectedIndex = 0;

  final List<String> _buttonLabels = ["Berlangsung", "Selesai", "Dibatalkan"];

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMMM yyyy', 'id_ID').format(dateTime);
  }

  String formatStatus(String status) {
    return switch (status) {
      'menunggu konfirmasi' => 'Menunggu Konfirmasi',
      'dibuat' => 'Pesanan Dibuat',
      'disiapkan' => 'Pesanan Disiapkan',
      'batal' => 'Pesanan Dibatalkan',
      _ => 'Error',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: white),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacementNamed('/home_page_user');
            }
          },
        ),
        title: Text(
          "Pesanan Saya",
          style: whiteTextStyle.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: StreamBuilder<List<Pesanan>>(
        stream: _pesananService.getPesananUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: zelow));
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          }

          final listPesanan = snapshot.data ?? [];

          final pesananBerlangsung =
              listPesanan
                  .where(
                    (data) =>
                        data.status == 'menunggu konfirmasi' ||
                        data.status == 'dibuat' ||
                        data.status == 'disiapkan',
                  )
                  .toList();

          final pesananSelesai =
              listPesanan.where((data) => data.status == 'selesai').toList();

          final pesananBatal =
              listPesanan.where((data) => data.status == 'batal').toList();

          List<Widget> currentList;

          switch (_selectedIndex) {
            case 0:
              currentList =
                  pesananBerlangsung
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: PesananBerlangsungCard(
                            idPesanan: item.idPesanan,
                            namaProduk: item.namaProduk,
                            quantity: item.quantity,
                            hargaSatuan: item.hargaSatuan,
                            status: formatStatus(item.status),
                            idToko: item.idToko,
                            gambar: item.gambarProduk,
                            tanggalPesanan: formatDate(item.waktuPesan),
                          ),
                        ),
                      )
                      .toList();
              break;
            case 1:
              currentList =
                  pesananSelesai
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: PesananSelesaiCard(
                            idPesanan: item.idPesanan,
                            tanggalPesanan: formatDate(item.waktuPesan),
                            namaProduk: item.namaProduk,
                            quantity: item.quantity,
                            hargaSatuan: item.hargaSatuan,
                            idToko: item.idToko,
                            gambar: item.gambarProduk,
                          ),
                        ),
                      )
                      .toList();
              break;
            case 2:
              currentList =
                  pesananBatal
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: PesananBatalCard(
                            idPesanan: item.idPesanan,
                            tanggalPesanan: formatDate(item.waktuPesan),
                            gambar: item.gambarProduk,
                            namaProduk: item.namaProduk,
                            quantity: item.quantity,
                            hargaSatuan: item.hargaSatuan,
                            idToko: item.idToko,
                          ),
                        ),
                      )
                      .toList();
              break;
            default:
              currentList = [];
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_buttonLabels.length, (index) {
                      bool isSelected = _selectedIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected ? zelow : white,
                            foregroundColor: isSelected ? white : zelow,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: zelow, width: 1.5),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: Text(
                            _buttonLabels[index],
                            style: normal.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 12),

                  currentList.isEmpty
                      ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        alignment: Alignment.center,
                        child: const Text(
                          'Belum ada pesanan untuk kategori ini',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : Column(children: currentList),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 1),
    );
  }
}
