import 'package:flutter/material.dart';
import 'package:zelow/components/keranjang_card.dart';
import 'package:zelow/components/keranjang_bottomnavbar.dart';
import 'package:zelow/models/keranjang_model.dart';
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
  List<KeranjangItem> _cartItems = [];

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
      if (_selectedItems.contains(item.produk.id)) {
        total += item.produk.harga * item.quantity;
      }
    }
    return total;
  }

  int get _selectedItemsCount {
    return _selectedItems.length;
  }

  void _handleCheckout() {
    final selectedOrders = _cartItems
        .where((item) => _selectedItems.contains(item.produk.id))
        .map(
          (item) => {
            'idProduk': item.produk.id, // PENTING untuk menghapus dari keranjang nanti
            'title': item.produk.nama,
            'imageUrl': item.produk.gambar,
            'price': item.produk.harga.toDouble(),
            'originalPrice': item.produk.harga.toDouble(), // Sesuaikan jika ada harga asli/diskon
            'quantity': item.quantity,
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

      body: StreamBuilder<List<KeranjangItem>>(
        stream: _keranjangService.getCartItems(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            _cartItems = [];
            if (_selectedItems.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _selectedItems.clear();
                });
              });
            }
            return const Center(
              child: Text(
                'Keranjang Anda Kosong',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          _cartItems = snapshot.data!;

          // Menampilkan data keranjang
          return ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              final isSelected = _selectedItems.contains(item.produk.id);

              return Dismissible(
                key: Key(item.produk.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _keranjangService.removeFromCart(item.produk.id);

                  setState(() {
                    if (_selectedItems.contains(item.produk.id)) {
                      _selectedItems.remove(item.produk.id);
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
                  onTap: () => _toggleSelection(item.produk.id), // Panggil fungsi toggle
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
