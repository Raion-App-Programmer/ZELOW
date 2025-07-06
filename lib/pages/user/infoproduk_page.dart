import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/info_produk_card.dart';
import 'package:zelow/pages/user/chekout_page.dart';

import 'package:zelow/models/produk_model.dart';

import 'package:zelow/pages/user/keranjang_page.dart'; // Tambahkan import ini
import 'package:zelow/services/keranjang_service.dart'; // Tambahkan import ini

class ProductInfoPage extends StatefulWidget {

  final Produk productData;

  const ProductInfoPage({super.key, required this.productData});

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  int itemCount = 0;

  void _addItem() {
    setState(() {
      itemCount++;
    });
  }

  void _removeItem() {
    setState(() {
      if (itemCount > 0) {
        itemCount--;
      }
    });
  }

  // backend keranjang
  final KeranjangService _keranjangService = KeranjangService();
  bool isAddingToCart = false;
  Future<void> _handleAddToCart() async {
    if (itemCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tentukan jumlah barang terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
    }
    setState(() {
      isAddingToCart = true;
    });

    try {
      // manggil fungsi keranjang service
      await _keranjangService.addToCart(widget.productData, itemCount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$itemCount ${widget.productData.nama} ditambahkan ke keranjang!'),
          backgroundColor: zelow,
          action: SnackBarAction(
            label: 'LIHAT',
            textColor: Colors.white,
            onPressed: () { // User dapat langsung pindah ke halaman keranjang
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => KeranjangKu()
                )
              );
            },
          ),
        )
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan ke keranjang: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isAddingToCart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double price = (widget.productData['price'] as num).toDouble();
    // double totalPrice = itemCount * price;

    int price = widget.productData.harga;
    int totalPrice = itemCount * price;

    return Scaffold(
      appBar: AppBar(title: Text('Detail Produk'), leading: BackButton()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoProdukCard(
              title: widget.productData.nama,
              imageUrl: widget.productData.urlGambar,
              rating: widget.productData.rating,
              jumlahTerjual: widget.productData.jumlahTerjual,
              likeCount: widget.productData.jumlahSuka,
              price: price,
              itemCount: itemCount,
              reviews: _buildReviews([]), // Masih kurang tau apa gunanya
              onSavePressed: () {},
              onSharePressed: () {},
              onAddPressed: _addItem,
              onRemovePressed: _removeItem,
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          itemCount > 0
              ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Icon(
                        //   Icons.shopping_bag,
                        //   size: 30,
                        //   color: zelow, 
                        //   // Warna Zelow
                        // ),
                        IconButton(
                          onPressed: isAddingToCart ? null : _handleAddToCart, 
                          icon: isAddingToCart
                          ? CircularProgressIndicator(color: zelow, strokeWidth: 3)
                          : Image.asset('assets/images/keranjangKu-icon.png', width: 25,)
                        ),
                        if (itemCount > 0)
                          Positioned(
                            right: -7,
                            top: -8,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: zelow,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 15,
                                minHeight: 15,
                              ),
                              child: Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Rp${totalPrice.toStringAsFixed(0)}',
                      style: greenTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (itemCount > 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CheckoutPage(
                                    orders: [
                                      {
                                        'title': widget.productData.nama,
                                        'imageUrl':
                                            widget.productData.urlGambar,
                                        'price': price,
                                        'quantity': itemCount,
                                        'originalPrice':
                                            widget.productData.harga,
                                      },
                                    ],
                                  ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: zelow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : SizedBox.shrink(),
    );
  }

  List<ReviewItem> _buildReviews(List<dynamic> reviewsData) {
    if (reviewsData.isEmpty) {
      return [];
    }
    return reviewsData
        .map(
          (review) => ReviewItem(
            reviewerName: review['name'] ?? '',
            reviewerImageUrl: review['imageUrl'] ?? '',
            rating: review['rating'] ?? 5.0,
          ),
        )
        .toList();
  }
}
