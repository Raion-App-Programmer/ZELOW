import 'package:flutter/material.dart';
import 'package:zelow/components/box_button.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/flash_sale_card.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/product_card.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:zelow/components/widget_slider.dart';
import 'package:zelow/pages/user/display_page.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/payment_option_page.dart';
import 'package:zelow/pages/user/payment_page.dart';
import 'package:zelow/pages/user/promotion_option_page.dart';
import 'package:zelow/pages/user/search_page.dart';
import 'package:zelow/pages/user/surprisebox_page.dart';

import '../../services/auth_service.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});
  static List previousSearchs = [];

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  void _handleLogout() {
    AuthService().logout(context);
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
                                  builder: (context) => DisplayPage(),
                                ),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurpriseBoxPage(),
                                ),
                              );
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
                                  builder: (context) => DisplayPage(),
                                ),
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
                                  builder: (context) => DisplayPage(),
                                ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Terdekat',
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
                                //navigasi ke semua
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
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              10,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0.5,
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width *
                                      0.42, // 42% dari layar
                                  child: ProductCard(
                                    imageUrl: 'assets/images/mie ayam.jpg',
                                    rating: 4.5,
                                    restaurantName: 'Nina Rasa',
                                    distance: '1.2 km',
                                    estimatedTime: '25 min',
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PromotionOptionPage()),
                  );
                },
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
