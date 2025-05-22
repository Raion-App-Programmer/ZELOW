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

import '../../services/auth_service.dart';

class TokoPageUser extends StatefulWidget {
  const TokoPageUser({super.key});

  @override
  State<TokoPageUser> createState() => _TokoPageUserState();
}

class _TokoPageUserState extends State<TokoPageUser> {
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.24, // Tinggi slider
                        child: HeaderToko(),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Masakan Padang Roda  Dua, Bendungan Sutami',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'nunito',
                                    fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Aneka masakan padang, Nasi padang, Rendang',
                                style: TextStyle(
                                  fontFamily: 'nunito',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Color(0xFFFFC837),),
                                        Text(
                                          "4.9",
                                          style: TextStyle(
                                            fontFamily: 'nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined, color: Color(0xFF676767)),
                                        Text(
                                          "2.4 km",
                                          style: TextStyle(
                                              fontFamily: 'nunito',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            color: Color(0xFF676767)
                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Icon(Icons.access_time, color: Color(0xFF676767)),
                                        Text(
                                          "10-25 min",
                                          style: TextStyle(
                                              fontFamily: 'nunito',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF676767)
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              )
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
                              VoucherTokoCard()
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
                                  onPressed: (){},
                                  isSelected: false
                              ),
                              FilterTokoButton(
                                  text: 'Makanan',
                                  onPressed: (){},
                                  isSelected: false
                              ),
                              FilterTokoButton(
                                  text: 'Minuman',
                                  onPressed: (){},
                                  isSelected: false
                              ),
                              FilterTokoButton(
                                  text: 'Flash Sale',
                                  onPressed: (){},
                                  isSelected: false
                              ),
                              FilterTokoButton(
                                  text: 'Tambahan',
                                  onPressed: (){},
                                  isSelected: false
                              ),
                              FilterTokoButton(
                                  text: 'Filter',
                                  onPressed: (){},
                                  isSelected: false
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Flash Sale',
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
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 3, // Jumlah restoran
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(), // Scroll bawaan dari Parent
                              itemBuilder: (context, index) {
                                return ProductTokoCard(
                                  imageUrl: 'assets/images/mie ayam.jpg',
                                  restaurantName: 'Nasi padang saus tiram',
                                  description: '6RBterjual | Disukai oleh 342',
                                  harga: 12.000,
                                  onTap: () {
                                    // Aksi ketika diklik
                                  },
                                );
                              },
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              'Makanan',
                              style: blackTextStyle.copyWith(
                                fontSize:
                                MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),


                          SizedBox(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 3, // Jumlah restoran
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(), // Scroll bawaan dari Parent
                              itemBuilder: (context, index) {
                                return ProductTokoCard(
                                  imageUrl: 'assets/images/naspad.jpg',
                                  restaurantName: 'Rendang',
                                  description: '6RBterjual | Disukai oleh 342',
                                  harga: 12.000,
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
        ],
      ),
    );
  }
}
