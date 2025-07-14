import 'package:flutter/material.dart';
import 'package:zelow/components/berlangsung_card.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/selesai_card.dart';
import 'package:zelow/components/batal_card.dart';

class PesananPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const PesananPage({super.key, required this.orders});

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int _selectedIndex = 0;
  final List<String> _buttonLabels = ["Berlangsung", "Selesai", "Dibatalkan"];

  List<Map<String, dynamic>> _pesananList = [];
  List<Map<String, dynamic>> _pesananSelesaiList = [];
  List<Map<String, dynamic>> _pesananBatalList = [];

  @override
  void initState() {
    super.initState();
    _pesananList = List.from(widget.orders);
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
            Navigator.pop(context);
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
                  return PesananBerlangsungCard(
                    orderNumber: _pesananList[index]['orderNumber'],
                    orderDate: _pesananList[index]['orderDate'],
                  );
                } else if (_selectedIndex == 1) {
                  return PesananSelesaiCard(
                    orderNumber: _pesananSelesaiList[index]['orderNumber'],
                    orderDate: _pesananSelesaiList[index]['orderDate'],
                  );
                } else {
                  return PesananBatalCard(
                    orderNumber: _pesananBatalList[index]['orderNumber'],
                    orderDate: _pesananBatalList[index]['orderDate'],
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
