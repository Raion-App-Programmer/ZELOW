import 'package:flutter/material.dart';
import 'package:zelow/components/box_button.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/flash_sale_card.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/product_card.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:zelow/components/widget_slider.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/pages/user/display_page.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/surprisebox_page.dart';
import 'package:zelow/pages/user/toko_page.dart';

import '../../services/toko_service.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final TokoServices _tokoService = TokoServices();

  // Widget _buildRekomendasiToko() {
  //   return FutureBuilder<Toko?>(
  //       future: _tokoService.getTokoRekomendasi()
  //       builder: builder
  //   );
  // }

  Widget _buildSectionTitle(
      BuildContext context,
      String title,
      VoidCallback onSeeAllPressed
  ){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(padding: EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: onSeeAllPressed,
            child: Text(
              'Lihat Semua',
              style: greenTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTokoHorizontal(Future<List<Toko>> futureToko, String sectionTypeForNavigation) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      child: FutureBuilder<List<Toko>>(
        future: futureToko,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: zelow,));
          }
          if (snapshot.hasError) {
            print("Error fetching toko list for $sectionTypeForNavigation: ${snapshot.error}");
            return Center(child: Text('Gagat memuat data toko.'),);
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidadk ada toko tersedia.'),);
          }
          final tokoList = snapshot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tokoList.length,
            itemBuilder: (context, index) {
              final toko = tokoList[index];
              return Container(
                width: 120.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ProductCard(
                  imageUrl: toko.gambar,
                  rating: toko.rating,
                  restaurantName: toko.nama,
                  distance: '${toko.jarak} km',
                  estimatedTime: toko.waktu,
                  onTap: () {
                    print('Toko ${toko.nama} diklik. ID: ${toko.id}');
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => TokoPageUser(tokoData: toko),
                        )
                    );
                  },
                ),
              );
            },
          );
        },
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
              SizedBox(
                height:
                  MediaQuery.of(context).size.height * 0.3, // Tinggi slider
                child: SliderWidget(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoxButton(
                            icon: Icons.location_on,
                            text: "Terdekat",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DisplayPage(pageTitle: "Terdekat", fetchType: "terdekat_full")
                                )
                              );
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          BoxButton(
                            icon: Icons.shopping_bag_rounded,
                            text: "Surprise Bag",
                            onTap: () {
                              Navigator.push(context, 
                              MaterialPageRoute(builder: (context)=> SurpriseBoxPage()));
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          BoxButton(
                            icon: Icons.star,
                            text: "Paling Laris",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DisplayPage(pageTitle: "Paling Laris", fetchType: "paling_laris_full")
                                  )
                              );
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          BoxButton(
                            icon: Icons.food_bank_outlined,
                            text: "Rekomendasi",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DisplayPage(pageTitle: "Semua Rekomendasi", fetchType: "rekomendasi_full")
                                  )
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Zeflash',
                              style: blackTextStyle.copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FlashsalePage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Lihat Semua',
                                style: greenTextStyle.copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              10,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1,
                                ),
                                child: FlashCard(
                                  imageUrl: 'assets/images/mie ayam.jpg',
                                  title: 'Mie Ayam Ceker',
                                  price: 'Rp.10.000',
                                  stock: 12,
                                  sold: 5,
                                  onTap: () {
                                    // navigasi ke checkout
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 16),
                      //       child: Text(
                      //         'Terdekat',
                      //         style: blackTextStyle.copyWith(
                      //           fontSize:
                      //               MediaQuery.of(context).size.width * 0.04,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: EdgeInsets.only(right: 16),
                      //       child: TextButton(
                      //         onPressed: () {
                      //           //navigasi ke semua
                      //         },
                      //         child: Text(
                      //           'Lihat Semua',
                      //           style: greenTextStyle.copyWith(
                      //             fontSize:
                      //                 MediaQuery.of(context).size.width * 0.03,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // SizedBox(
                      //   height:
                      //       MediaQuery.of(context).size.height *
                      //       0.20,
                        // child: SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: List.generate(
                        //       10,
                        //       (index) => Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 0.5,
                        //         ),
                        //         child: SizedBox(
                        //           width:
                        //               MediaQuery.of(context).size.width *
                        //               0.42, // 42% dari layar
                        //           child: ProductCard(
                        //             imageUrl: 'assets/images/mie ayam.jpg',
                        //             rating: 4.5,
                        //             restaurantName: 'Nina Rasa',
                        //             distance: '1.2 km',
                        //             estimatedTime: '25 min',
                        //             onTap: () {},
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      // ),

                      _buildSectionTitle(context, 'Terdekat', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayPage(pageTitle: "Terdekat", fetchType: "terdekat_full")
                          )
                        );
                      }),
                      _buildTokoHorizontal(_tokoService.getAllTokoTerdekat(), "terdekat"),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Rekomendasi Untukmu',
                              style: blackTextStyle.copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // List Card ke BAWAH
                          SizedBox(
                            height: 400, // Biar bisa scroll kalau banyak
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 5, // Jumlah restoran
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(), // Scroll bawaan dari Parent
                              itemBuilder: (context, index) {
                                return DisplayCard(
                                  imageUrl: 'assets/images/mie ayam.jpg',
                                  restaurantName: 'Warung Mie Ayam',
                                  description: 'Mie ayam enak, porsi banyak!',
                                  rating: 4.5,
                                  distance: '1.2 km',
                                  estimatedTime: '15 min',
                                  onTap: () {
                                    // Aksi ketika diklik
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.23,
            left: 20,
            right: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: zelow, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Lagi pengen makan apa?",
                  prefixIcon: Icon(Icons.search, color: zelow),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 0),
    );
  }
}
