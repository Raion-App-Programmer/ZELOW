import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/info_produk_card.dart';
import 'package:zelow/components/review_item.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/pages/user/keranjang_page.dart';
import 'package:zelow/pages/user/chekout_page.dart';
import 'package:zelow/pages/user/semuaulasan_page.dart';
import 'package:zelow/services/keranjang_service.dart';
import 'package:zelow/services/produk_service.dart';
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
  final ProdukService _produkService = ProdukService();
  final KeranjangService _keranjangService = KeranjangService();

  int itemCount = 0;
  String? alamatTokoProduk;
  bool isAddingToCart = false;
  List<Map<String, dynamic>> _reviews = [];
  bool _isLoadingReviews = true;

  @override
  void initState() {
    super.initState();
    _produkService.getAlamatTokoByProdukId(widget.productData.idToko).then((
      alamat,
    ) {
      setState(() {
        alamatTokoProduk = alamat;
      });
    });

    _loadReviews();
  }

  Future<void> _loadReviews() async {
    final produkId = widget.productData.idProduk;

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('produk')
              .doc(produkId)
              .collection('ulasan')
              .orderBy('tanggal', descending: true)
              .limit(5)
              .get();

      final loadedReviews =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'name': data['fullname'] ?? 'Anonim',
              'imageUrl': 'https://i.imgur.com/QCNbOAo.png',
              'komentar': data['komentar'] ?? '',
              'rating': (data['rating'] ?? 5).toDouble(),
            };
          }).toList();

      setState(() {
        _reviews = loadedReviews;
        _isLoadingReviews = false;
      });
    } catch (e) {
      print('Gagal memuat ulasan untuk produk $produkId: $e');
      setState(() {
        _isLoadingReviews = false;
      });
    }
  }

  void _addItem() {
    int stokTersisa = widget.productData.stok - widget.productData.terjual;
    int maxPembelian = widget.productData.isFlashSale ? 2 : stokTersisa;

    if (itemCount >= maxPembelian) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                widget.productData.isFlashSale
                    ? 'Pembelian flash sale maksimal 2 item'
                    : 'Pembelian mencapai batas maksimum stok',
              ),
              backgroundColor: zelow,
              duration: const Duration(seconds: 1),
            ),
          );
      }
      return;
    }

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

  Future<void> _handleAddToCart() async {
    if (itemCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
    bool isFlashSale = widget.productData.isFlashSale;
    double originalPrice = widget.productData.harga;
    double price = isFlashSale ? originalPrice * 0.8 : originalPrice;
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
              stok: widget.productData.stok,
              terjual: widget.productData.terjual,
              originalPrice: widget.productData.harga,
              isFlashSale: widget.productData.isFlashSale,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => SemuaUlasanPage(
                                idProduk: widget.productData.idProduk,
                                productName:
                                    widget
                                        .productData
                                        .nama, // Pass product name
                              ),
                        ),
                      );
                    },
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
              child:
                  _isLoadingReviews
                      ? const Center(child: CircularProgressIndicator())
                      : _buildReviews(_reviews),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar:
          itemCount > 0
              ? Container(
                height: 110,
                padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
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
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: zelow,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
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
                    const SizedBox(width: 12),
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
                    const SizedBox(width: 12),
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
                                        'idToko': widget.productData.idToko,
                                        'idProduk': widget.productData.idProduk,
                                        'title': widget.productData.nama,
                                        'imageUrl': widget.productData.gambar,
                                        'price': price,
                                        'quantity': itemCount,
                                        'originalPrice':
                                            widget.productData.harga,
                                        'nama': widget.tokoData.nama,
                                        'alamat': widget.tokoData.alamat,
                                        'stok': widget.productData.stok,
                                        'terjual': widget.productData.terjual,
                                        'isFlashSale':
                                            widget.productData.isFlashSale,
                                        'deskripsi':
                                            widget.productData.deskripsi,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                      ),
                      child: const Text(
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children:
            reviewsData.map((review) {
              return Padding(
                padding: const EdgeInsets.only(right: 4),
                child: ReviewItem(
                  reviewerName: review['name'],
                  reviewerImageUrl: review['imageUrl'],
                  komentar: review['komentar'],
                  rating: review['rating'],
                ),
              );
            }).toList(),
      ),
    );
  }
}
