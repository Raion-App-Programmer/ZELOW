import 'package:flutter/material.dart';
import 'package:zelow/components/keranjang_card.dart';
import 'package:zelow/components/keranjang_bottomnavbar.dart';
import 'package:zelow/models/keranjang_model.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/pages/user/chekout_page.dart';
import 'package:zelow/services/keranjang_service.dart';

class KeranjangKu extends StatefulWidget {
  const KeranjangKu({super.key});

  @override
  State<KeranjangKu> createState() => _KeranjangKuState();
}

class _KeranjangKuState extends State<KeranjangKu> {
  // Backend Keranjang
  final KeranjangService _keranjangService = KeranjangService();

  final Set<String> _selectedItems = {};
  List<KeranjangModel> _cartItems = [];

  void _toggleSelection(String idProduk) {
    setState(() {
      if (_selectedItems.contains(idProduk)) {
        _selectedItems.remove(idProduk);
      } else {
        _selectedItems.add(idProduk);
      }
    });
  }

  double get _selectedTotalPrice {
    double total = 0;
    for (var item in _cartItems) {
      if (_selectedItems.contains(item.produk.idProduk)) {
        total += item.produk.harga * item.quantity;
      }
    }
    return total;
  }

  int get _selectedItemsCount {
    return _selectedItems.length;
  }

  void _handleCheckout() {
    final selectedOrders =
        _cartItems
            .where((item) => _selectedItems.contains(item.produk.idProduk))
            .map(
              (item) => {
                'idProduk': item.produk.idProduk,
                'nama': item.produk.nama,
                'gambar': item.produk.gambar,
                'harga': item.produk.harga,
                'hargaAsli': item.produk.harga, // Fitur diskon menyusul (belum jalan)
                'quantity': item.quantity,
                'alamat': item.alamat,
                'idToko': item.produk.idToko,
                'kategori': item.produk.kategori,
                'rating': item.produk.rating,
              },
            )
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(orders: selectedOrders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff06C474),
        toolbarHeight: 60,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Keranjangku",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<List<KeranjangModel>>(
        stream: _keranjangService.getCartItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            _cartItems = [];
            if (_selectedItems.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _selectedItems.clear();
                });
              });
            }
            return const Center();
          }

          _cartItems = snapshot.data!;

          // Menampilkan data keranjang
          return ListView.builder(
            padding: const EdgeInsets.only(top: 12),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              final isSelected = _selectedItems.contains(item.produk.idProduk);

              return Dismissible(
                key: Key(item.produk.idProduk),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _keranjangService.removeFromCart(item.produk.idProduk);

                  setState(() {
                    if (_selectedItems.contains(item.produk.idProduk)) {
                      _selectedItems.remove(item.produk.idProduk);
                    }
                  });
                },

                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                child: CardItemSample(
                  item: item,
                  isSelected: isSelected,
                  onTap: () => _toggleSelection(item.produk.idProduk),
                ),
              );
            },
          );
        },
      ),

      bottomNavigationBar: CartBottomNavBar(
        totalPrice: _selectedTotalPrice,
        itemCount: _selectedItemsCount,
        onCheckoutPressed: _handleCheckout,
      ),
    );
  }
}
