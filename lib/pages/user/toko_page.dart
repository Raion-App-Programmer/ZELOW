import 'package:flutter/material.dart';
import 'package:zelow/components/add_product_toko.dart';
import 'package:zelow/components/box_button.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/filter_toko_button.dart';
import 'package:zelow/components/flash_sale_card.dart';
import 'package:zelow/components/header_toko.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/product_card.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:zelow/components/voucher_toko_card.dart';
import 'package:zelow/components/widget_slider.dart';
import 'package:zelow/pages/user/display_page.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/surprisebox_page.dart';
import 'package:zelow/services/toko_service.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/toko_model.dart';
import '../../services/auth_service.dart';

class TokoPageUser extends StatefulWidget {
  final Toko tokoData;

  const TokoPageUser({super.key, required this.tokoData});

  @override
  State<TokoPageUser> createState() => _TokoPageUserState();
}

class _TokoPageUserState extends State<TokoPageUser> {
  Future<List<Product>> fetchProdukByToko(String idToko) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('produk')
            .where('id_toko', isEqualTo: idToko)
            .get();

    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
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
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: HeaderToko(imageUrl: widget.tokoData.gambar),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 10.0,
                            right: 10.0,
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
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                widget.tokoData.deskripsi,
                                style: TextStyle(
                                  fontFamily: 'nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(15.0),
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
                                        Text(
                                          widget.tokoData.rating
                                              .toStringAsFixed(1),
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
                                          Icons.location_on_outlined,
                                          color: Color(0xFF676767),
                                        ),
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
                              Divider(thickness: 1),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FilterTokoButton(
                                text: 'Favorit',
                                onPressed: () {},
                                isSelected: false,
                              ),
                              FilterTokoButton(
                                text: 'Makanan',
                                onPressed: () {},
                                isSelected: false,
                              ),
                              FilterTokoButton(
                                text: 'Minuman',
                                onPressed: () {},
                                isSelected: false,
                              ),
                              FilterTokoButton(
                                text: 'Flash Sale',
                                onPressed: () {},
                                isSelected: false,
                              ),
                              FilterTokoButton(
                                text: 'Tambahan',
                                onPressed: () {},
                                isSelected: false,
                              ),
                              FilterTokoButton(
                                text: 'Filter',
                                onPressed: () {},
                                isSelected: false,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 16),
                      //       child: Text(
                      //         'Flash Sale',
                      //         style: blackTextStyle.copyWith(
                      //           fontSize:
                      //               MediaQuery.of(context).size.width * 0.045,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(height: 8),

                      //     // List Card ke BAWAH
                      //     SizedBox(
                      //       child: ListView.builder(
                      //         padding: EdgeInsets.zero,
                      //         itemCount: 3, // Jumlah flash sale
                      //         shrinkWrap: true,
                      //         physics:
                      //             const NeverScrollableScrollPhysics(), // Scroll bawaan dari Parent
                      //         itemBuilder: (context, index) {
                      //           return ProductTokoCard(
                      //             imageUrl: 'assets/images/mie ayam.jpg',
                      //             restaurantName: 'Nasi padang saus tiram',
                      //             description: '6rb terjual | Disukai oleh 342',
                      //             harga: 12.000,
                      //             onTap: () {
                      //               // Aksi ketika diklik
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ),

                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 16,
                      //         vertical: 8,
                      //       ),
                      //       child: Text(
                      //         'Makanan',
                      //         style: blackTextStyle.copyWith(
                      //           fontSize:
                      //               MediaQuery.of(context).size.width * 0.045,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),

                      //     SizedBox(
                      //       child: ListView.builder(
                      //         padding: EdgeInsets.zero,
                      //         itemCount: 3, // Jumlah makanan
                      //         shrinkWrap: true,
                      //         physics:
                      //             const NeverScrollableScrollPhysics(), // Scroll bawaan dari Parent
                      //         itemBuilder: (context, index) {
                      //           return ProductTokoCard(
                      //             imageUrl: 'assets/images/naspad.jpg',
                      //             restaurantName: 'Rendang',
                      //             description: '6rb terjual | Disukai oleh 342',
                      //             harga: 12.000,
                      //             onTap: () {
                      //               // Aksi ketika diklik
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(height: 30),
                      //   ],
                      // ),

                      // ambil data dari firebase
                      FutureBuilder<List<Product>>(
                        future: fetchProdukByToko(widget.tokoData.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Terjadi kesalahan: ${snapshot.error}',
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('Belum ada produk.'),
                            );
                          }

                          final products = snapshot.data!;
                          final makanan =
                              products
                                  .where((p) => p.kategori == 'makanan')
                                  .toList();
                          final minuman =
                              products
                                  .where((p) => p.kategori == 'minuman')
                                  .toList();
                          final tambahan =
                              products
                                  .where((p) => p.kategori == 'tambahan')
                                  .toList();

                          Widget buildProdukSection(
                            String title,
                            List<Product> items,
                          ) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    title,
                                    style: blackTextStyle.copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: items.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final item = items[index];
                                    return ProductTokoCard(
                                      imageUrl: item.gambar,
                                      restaurantName: item.nama,
                                      description:
                                          '${item.jumlahPembelian} terjual | Disukai oleh ${item.jumlahDisukai}',
                                      harga: item.harga,
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ],
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (makanan.isNotEmpty)
                                buildProdukSection('Makanan', makanan),
                              if (minuman.isNotEmpty)
                                buildProdukSection('Minuman', minuman),
                              if (tambahan.isNotEmpty)
                                buildProdukSection('Tambahan', tambahan),
                              const SizedBox(height: 30),
                            ],
                          );
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
