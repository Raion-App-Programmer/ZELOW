import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/info_produk_card.dart';
import 'package:zelow/components/review_item.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/pages/user/keranjang_page.dart';
import 'package:zelow/pages/user/chekout_page.dart';
import 'package:zelow/services/keranjang_service.dart';
import 'package:intl/intl.dart';

class ProductInfoPage extends StatefulWidget {
  final Produk productData;
  final Toko tokoData;

  const ProductInfoPage({
    super.key,
    required this.productData,
    required this.tokoData,
  });

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
      return;
    }
    setState(() {
      isAddingToCart = true;
    });

    try {
      await _keranjangService.addToCart(widget.productData, itemCount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$itemCount ${widget.productData.nama} ditambahkan ke keranjang!',
          ),
          backgroundColor: zelow,
          action: SnackBarAction(
            label: 'LIHAT',
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KeranjangKu()),
              );
            },
          ),
        ),
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
    double price = widget.productData.harga;
    double totalPrice = itemCount * price;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: zelow,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoProdukCard(
              title: widget.productData.nama,
              imageUrl: widget.productData.gambar,
              rating: widget.productData.rating,
              jumlahTerjual: widget.productData.jumlahPembelian,
              likeCount: widget.productData.jumlahDisukai,
              price: price,
              itemCount: itemCount,
              onSavePressed: () {},
              onSharePressed: () {},
              onAddPressed: _addItem,
              onRemovePressed: _removeItem,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kata Mereka',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFE6F9F1),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      minimumSize: const Size(0, 28),
                    ),
                    child: const Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF06C474),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: _buildReviews([
                // dummy review
                // {
                //   'name': 'Nana Mirdad',
                //   'imageUrl': 'https://i.imgur.com/QCNbOAo.png',
                //   'komentar': 'enakkk',
                //   'rating': 5.0,
                // },
                // {
                //   'name': 'Nana Mirdad',
                //   'imageUrl': 'https://i.imgur.com/QCNbOAo.png',
                //   'komentar': 'enakkk',
                //   'rating': 5.0,
                // },
              ]),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar:
          itemCount > 0
              ? Container(
                height: 120,
                padding: EdgeInsets.only(bottom: 24, left: 18, right: 18),
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
                        IconButton(
                          onPressed: isAddingToCart ? null : _handleAddToCart,
                          icon:
                              isAddingToCart
                                  ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: zelow,
                                      strokeWidth: 3,
                                    ),
                                  )
                                  : Image.asset(
                                    'assets/images/keranjangKu-icon.png',
                                    width: 28,
                                  ),
                        ),
                        if (itemCount > 0)
                          Positioned(
                            right: -6,
                            top: -6,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: zelow,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '$itemCount',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp',
                            decimalDigits: 0,
                          ).format(totalPrice),
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: zelow,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

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
                                        'imageUrl': widget.productData.gambar,
                                        'price': price,
                                        'quantity': itemCount,
                                        'originalPrice':
                                            widget.productData.harga,
                                        'alamat': widget.tokoData.alamat,
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
                          horizontal: 40,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }

  Widget _buildReviews(List<dynamic> reviewsData) {
    if (reviewsData.isEmpty) {
      return Container(
        width: double.infinity,
        height: 100,
        alignment: Alignment.center,
        child: const Text(
          'Belum ada ulasan untuk produk ini',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reviewsData.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final review = reviewsData[index];
          return Padding(
            padding: EdgeInsets.only(right: 4),
            child: ReviewItem(
              reviewerName: review['name'] ?? 'Anonim',
              reviewerImageUrl:
                  review['imageUrl'] ?? 'https://i.imgur.com/QCNbOAo.png',
              komentar: review['komentar'] ?? '',
              rating: (review['rating'] ?? 5.0).toDouble(),
            ),
          );
        },
      ),
    );
  }
}
