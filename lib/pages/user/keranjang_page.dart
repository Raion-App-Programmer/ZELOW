import 'package:flutter/material.dart';
import 'package:zelow/components/keranjang_card.dart';
import 'package:zelow/components/keranjang_bottomnavbar.dart';
import 'package:zelow/models/product.dart';
import 'package:zelow/pages/user/home_page_user.dart';

class KeranjangKu extends StatefulWidget {
  const KeranjangKu({super.key});

  @override
  State<KeranjangKu> createState() => _KeranjangKuState();
}

class _KeranjangKuState extends State<KeranjangKu> {
  final List<Product> _products = List.generate(
    6,
    (index) => Product(
      id: 'dummy-id-$index',
      nama: "Nasi Padang, Ayam Kare",
      gambar: 'assets/images/naspad.jpg',
      harga: 13000,
      rating: 4.5,
      jumlahDisukai: 10,
      jumlahPembelian: 25,
      kategori: 'makanan',
      idToko: 'dummy-toko-$index',
      kuantitas: 99,
      isSelected: false,
    ),
  );

  void toggleSelection(int index) {
    setState(() {
      _products[index].isSelected = !_products[index].isSelected;
    });
  }

  int get selectedCount => _products.where((p) => p.isSelected).length;

  double get totalPrice => _products
      .where((p) => p.isSelected)
      .fold(0, (sum, p) => sum + (p.harga * p.kuantitas));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff06C474),
        toolbarHeight: 80,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "KeranjangKu",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(_products.length, (index) {
            return GestureDetector(
              onTap: () => toggleSelection(index),
              child: CardItemSample(
                product: _products[index],
                onTap: () => toggleSelection(index),
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: CartBottomNavBar(
        totalPrice: totalPrice,
        itemCount: selectedCount,
      ),
    );
  }
}
