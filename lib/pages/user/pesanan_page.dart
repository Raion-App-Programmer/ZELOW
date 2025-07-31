import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    final dateTime = timestamp.toDate();
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
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
      body: Column(
        children: [
          const SizedBox(height: 16),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: zelow),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    _buttonLabels[index],
                    style: normal.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),

          SizedBox(height: MediaQuery.of(context).size.width * 0.03),

          Expanded(
            child: StreamBuilder<List<Pesanan>>(
              stream: _pesananService.getPesananUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: zelow,),);
                }

                if (snapshot.hasError) {
                  log('Error: ${snapshot.error}');
                  return Center();
                  
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center();
                }

                final listPesanan = snapshot.data!;

                // final Map<String, List<Pesanan>> grouped = {};

                // for (var pesanan in listPesanan) {
                //   String idPesanan = pesanan.idPesanan;

                //   if (!grouped.containsKey(idPesanan)) {
                //     grouped[idPesanan] = [];
                //   }

                //   grouped[idPesanan]!.add(pesanan);
                // }

                final pesananBerlangsung = listPesanan
                        .where((data) => data.status == 'berlangsung')
                        .toList();
                final pesananSelesai =listPesanan
                        .where((data) => data.status == 'selesai')
                        .toList();
                final pesananBatal = listPesanan
                        .where((data) => data.status == 'batal')
                        .toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount:
                      _selectedIndex == 0
                          ? pesananBerlangsung.length
                          : _selectedIndex == 1
                          ? pesananSelesai.length
                          : pesananBatal.length,
                  itemBuilder: (context, index) {
                    final Pesanan item;
                    if (_selectedIndex == 0) {
                      item = pesananBerlangsung[index];

                      return PesananBerlangsungCard(
                        orderNumber: item.idPesanan,
                        orderDate: formatDate(item.waktuPesan),
                      );

                    } else if (_selectedIndex == 1) {
                      item = pesananSelesai[index];

                      return PesananSelesaiCard(
                        orderNumber: item.idPesanan,
                        orderDate: formatDate(item.waktuPesan),
                      );

                    } else {
                      item = pesananBatal[index];

                      return PesananBatalCard(
                        orderNumber: item.idPesanan,
                        orderDate: formatDate(item.waktuPesan),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 1),
    );
  }
}
