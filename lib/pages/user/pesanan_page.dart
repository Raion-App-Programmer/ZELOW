import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/berlangsung_card.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/selesai_card.dart';
import 'package:zelow/components/batal_card.dart';
import 'package:zelow/models/pesanan_model.dart';

class PesananPage extends StatefulWidget {
  final List<Pesanan> orders;

  const PesananPage({super.key, required this.orders});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int _selectedIndex = 0;
  final List<String> _buttonLabels = ["Berlangsung", "Selesai", "Dibatalkan"];

  List<Pesanan> _pesananList = [];
  List<Pesanan> _pesananSelesaiList = [];
  List<Pesanan> _pesananBatalList = [];

  @override
  void initState() {
    super.initState();
    _pesananList = widget.orders.where((order) => order.status == 'berlangsung').toList();
    _pesananSelesaiList = widget.orders.where((order) => order.status == 'selesai').toList();
    _pesananBatalList = widget.orders.where((order) => order.status == 'batal').toList();

  }

  String formatDate(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.year}";
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount:
                  _selectedIndex == 0
                      ? _pesananList.length
                      : _selectedIndex == 1
                      ? _pesananSelesaiList.length
                      : _pesananBatalList.length,
              itemBuilder: (context, index) {
                if (_selectedIndex == 0) {
                  final order = _pesananList[index];
                  return PesananBerlangsungCard(
                    orderNumber: order.orderNumber,
                    orderDate: formatDate(order.orderDate),
                  );
                } else if (_selectedIndex == 1) {
                  final order = _pesananSelesaiList[index];
                  return PesananSelesaiCard(
                    orderNumber: order.orderNumber,
                    orderDate: formatDate(order.orderDate),
                  );
                } else {
                  final order = _pesananBatalList[index];
                  return PesananBatalCard(
                    orderNumber: order.orderNumber,
                    orderDate: formatDate(order.orderDate),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 1),
    );
  }
}
