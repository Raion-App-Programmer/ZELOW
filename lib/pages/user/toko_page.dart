import 'package:flutter/material.dart';
import 'package:zelow/components/add_product_toko.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/filter_toko_button.dart';
import 'package:zelow/components/header_toko.dart';
import 'package:zelow/components/voucher_toko_card.dart';
import 'package:zelow/pages/user/infoproduk_page.dart';
import 'package:zelow/models/produk_model.dart';
import '../../models/toko_model.dart';
import '../../services/produk_service.dart';
import 'package:zelow/services/flashsale_service.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/utils/time_slot_utils.dart';

class TokoPageUser extends StatefulWidget {
  final Toko tokoData;

  const TokoPageUser({super.key, required this.tokoData});

  @override
  State<TokoPageUser> createState() => _TokoPageUserState();

  int getCurrentFlashSaleIndex() {
    final now = DateTime.now();
    final slots = getTimeSlots();
    for (int i = 0; i < slots.length; i++) {
      if (now.isAfter(slots[i]['start']!) && now.isBefore(slots[i]['end']!)) {
        return i;
      }
    }
    return 0;
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}

class _TokoPageUserState extends State<TokoPageUser> {
  final ProdukService _produkService = ProdukService();
  final FlashSaleService _flashSaleService = FlashSaleService();
  late Future<List<Produk>> _produkList;
  late Future<List<Produk>> _flashSaleProduk;

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _produkList = _produkService.getProdukByToko(widget.tokoData.id);
    _flashSaleProduk = _flashSaleService.getFlashSaleProdukByTime(
      widget.getCurrentFlashSaleIndex(),
    );
  }

  Widget buildFlashSaleSection(List<Produk> flashSaleProduk) {
    if (flashSaleProduk.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCategoryTitle('Flash Sale'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: flashSaleProduk.length,
          itemBuilder: (context, index) {
            final dataProduk = flashSaleProduk[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ProductTokoCard(
                imageUrl: dataProduk.gambar,
                restaurantName: dataProduk.nama,
                description:
                    '${dataProduk.jumlahPembelian} terjual | Disukai oleh ${dataProduk.jumlahDisukai}',
                harga: dataProduk.harga,
                isFlashSale: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProductInfoPage(
                            productData: dataProduk.copyWith(isFlashSale: true),
                            tokoData: dataProduk.toko!,
                          ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildProdukCardByCategory(List<Produk> produk, String kategori) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: produk.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dataProduk = produk[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ProductTokoCard(
            imageUrl: dataProduk.gambar,
            restaurantName: dataProduk.nama,
            description:
                '${dataProduk.jumlahPembelian} terjual | Disukai oleh ${dataProduk.jumlahDisukai}',
            harga: dataProduk.harga,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ProductInfoPage(
                        productData: dataProduk,
                        tokoData: dataProduk.toko!,
                      ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildCategoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
      child: Text(
        title,
        style: blackTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: HeaderToko(imageUrl: widget.tokoData.gambar),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 14.0,
                            right: 14.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.tokoData.nama,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'nunito',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                widget.tokoData.deskripsi,
                                style: TextStyle(
                                  fontFamily: 'nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFFFC837),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          widget.tokoData.rating
                                              .toStringAsFixed(1),
                                          style: TextStyle(
                                            fontFamily: 'nunito',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Color(0xFF676767),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${widget.tokoData.jarak} km",
                                          style: TextStyle(
                                            fontFamily: 'nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF676767),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Color(0xFF676767),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${widget.tokoData.waktu} min",
                                          style: TextStyle(
                                            fontFamily: 'nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF676767),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(thickness: 0.8),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 12,
                            bottom: 4,
                          ),

                          child: Row(
                            spacing: 10,
                            children: [
                              VoucherTokoCard(),
                              VoucherTokoCard(),
                              VoucherTokoCard(),
                              VoucherTokoCard(),
                            ],
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              FilterTokoButton(
                                text: 'Flash Sale',
                                onPressed: () {
                                  setState(() {
                                    selectedCategory =
                                        selectedCategory == 'flashsale'
                                            ? null
                                            : 'flashsale';
                                  });
                                },
                                isSelected: selectedCategory == 'flashsale',
                              ),
                              FilterTokoButton(
                                text: 'Makanan',
                                onPressed: () {
                                  setState(() {
                                    selectedCategory =
                                        selectedCategory == 'makanan'
                                            ? null
                                            : 'makanan';
                                  });
                                },
                                isSelected: selectedCategory == 'makanan',
                              ),
                              FilterTokoButton(
                                text: 'Minuman',
                                onPressed: () {
                                  setState(() {
                                    selectedCategory =
                                        selectedCategory == 'minuman'
                                            ? null
                                            : 'minuman';
                                  });
                                },
                                isSelected: selectedCategory == 'minuman',
                              ),
                              FilterTokoButton(
                                text: 'Tambahan',
                                onPressed: () {
                                  setState(() {
                                    selectedCategory =
                                        selectedCategory == 'tambahan'
                                            ? null
                                            : 'tambahan';
                                  });
                                },
                                isSelected: selectedCategory == 'tambahan',
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (selectedCategory == null ||
                          selectedCategory == 'flashsale') ...[
                        FutureBuilder<List<Produk>>(
                          future: _flashSaleProduk,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Gagal memuat flash sale: ${snapshot.error}',
                                ),
                              );
                            }

                            final flashSaleList = snapshot.data ?? [];
                            final filtered =
                                flashSaleList
                                    .where(
                                      (produk) =>
                                          produk.idToko == widget.tokoData.id,
                                    )
                                    .toList();

                            return buildFlashSaleSection(filtered);
                          },
                        ),
                      ],

                      // Daftar Produk dengan firebase firestore (Hery)
                      FutureBuilder<List<Produk>>(
                        future: _produkList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Gagal memuat data produk: ${snapshot.error}',
                              ),
                            );
                          }

                          final produkList = snapshot.data!;

                          if (selectedCategory == null) {
                            final makananProduk =
                                produkList
                                    .where((p) => p.kategori == 'makanan')
                                    .toList();
                            final minumanProduk =
                                produkList
                                    .where((p) => p.kategori == 'minuman')
                                    .toList();
                            final tambahanProduk =
                                produkList
                                    .where((p) => p.kategori == 'tambahan')
                                    .toList();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (makananProduk.isNotEmpty) ...[
                                  buildCategoryTitle('Makanan'),
                                  buildProdukCardByCategory(
                                    makananProduk,
                                    'makanan',
                                  ),
                                ],
                                if (minumanProduk.isNotEmpty) ...[
                                  buildCategoryTitle('Minuman'),
                                  buildProdukCardByCategory(
                                    minumanProduk,
                                    'minuman',
                                  ),
                                ],
                                if (tambahanProduk.isNotEmpty) ...[
                                  buildCategoryTitle('Tambahan'),
                                  buildProdukCardByCategory(
                                    tambahanProduk,
                                    'tambahan',
                                  ),
                                ],
                                const SizedBox(height: 25),
                              ],
                            );
                          } else if (selectedCategory != 'flashsale') {
                            // Filter kategori biasa
                            final filteredProduk =
                                produkList
                                    .where(
                                      (p) => p.kategori == selectedCategory,
                                    )
                                    .toList();

                            if (filteredProduk.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Tidak ada produk untuk kategori ini',
                                ),
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildCategoryTitle(
                                  selectedCategory!.capitalize(),
                                ),
                                buildProdukCardByCategory(
                                  filteredProduk,
                                  selectedCategory!,
                                ),
                                const SizedBox(height: 25),
                              ],
                            );
                          } else {
                            // selectedCategory == 'flashsale' → produk flash sale sudah ditampilkan di atas
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
