import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/info_produk_card.dart';
import 'package:zelow/pages/user/chekout_page.dart';

import 'package:zelow/models/produk_model.dart';

import 'package:zelow/pages/user/keranjang_page.dart'; // Tambahkan import ini
import 'package:zelow/services/keranjang_service.dart';
import 'package:zelow/services/produk_service.dart'; // Tambahkan import ini

class ProductInfoPage extends StatefulWidget {
  final Produk produk;

  const ProductInfoPage({super.key, required this.produk});

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  final ProdukService _produkService = ProdukService();
  int itemCount = 0;
  String? alamatTokoProduk;

  @override
  void initState() {
    super.initState();
    _produkService.getAlamatTokoByProdukId(widget.produk.idToko).then((
      alamat,
    ) {
      setState(() {
        alamatTokoProduk = alamat;
      });
    });
  }

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
    setState(() {
      isAddingToCart = true;
    });

    try {
      // manggil fungsi keranjang service
      await _keranjangService.addToCart(widget.produk, itemCount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$itemCount ${widget.produk.nama} ditambahkan ke keranjang!',
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
    double price = widget.produk.harga;
    double totalPrice = itemCount * price;
    
    return Scaffold(
      appBar: AppBar(title: Text('Detail Produk'), leading: BackButton()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoProdukCard(
              title: widget.produk.nama,
              imageUrl: widget.produk.gambar,
              rating: widget.produk.rating,
              jumlahTerjual: widget.produk.jumlahPembelian,
              likeCount: widget.produk.jumlahDisukai,
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
                        IconButton(
                          onPressed: isAddingToCart ? null : _handleAddToCart,
                          icon:
                              isAddingToCart
                                  ? CircularProgressIndicator(
                                    color: zelow,
                                    strokeWidth: 3,
                                  )
                                  : Image.asset(
                                    'assets/images/keranjangKu-icon.png',
                                    width: 25,
                                  ),
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
                                        'nama': widget.produk.nama,
                                        'gambar': widget.produk.gambar,
                                        'harga': price,
                                        'quantity': itemCount,
                                        'hargaAsli': widget.produk.harga,
                                        'alamat': alamatTokoProduk,
                                        'idProduk': widget.produk.idProduk,
                                        'idToko': widget.produk.idToko,
                                        'kategori': widget.produk.kategori,
                                        'rating': widget.produk.rating,
                                        'deskripsi': widget.produk.deskripsi,
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
