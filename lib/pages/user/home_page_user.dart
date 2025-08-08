import 'package:flutter/material.dart';
import 'package:zelow/components/box_button.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/flash_sale_card.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/product_card.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:zelow/components/widget_slider.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/pages/user/display_page.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/infoproduk_page.dart';
import 'package:zelow/pages/user/search_page.dart';
import 'package:zelow/pages/user/surprisebox_page.dart';
import 'package:zelow/pages/user/toko_page.dart';
import 'package:zelow/services/produk_service.dart';
import '../../services/toko_service.dart';
import 'package:intl/intl.dart';
import 'package:zelow/utils/time_slot_utils.dart';
import 'package:zelow/services/flashsale_service.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});
  static List previousSearchs = [];

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final TokoServices _tokoService = TokoServices();
  final ProdukService _produkService = ProdukService();
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  final FlashSaleService _flashSaleService = FlashSaleService();

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

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    VoidCallback onSeeAllPressed,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: onSeeAllPressed,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFE6F9F1),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 24),
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
        ),
      ],
    );
  }

  Widget _buildTokoHorizontal(
    Future<List<Toko>> futureToko,
    String sectionTypeForNavigation,
  ) {
    return SizedBox(
      height: 220,
      child: FutureBuilder<List<Toko>>(
        future: futureToko,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: zelow));
          }
          if (snapshot.hasError) {
            print(
              "Error fetching toko list for $sectionTypeForNavigation: ${snapshot.error}",
            );
            return Center(child: Text('Gagal memuat data toko.'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada toko tersedia.'));
          }
          final tokoList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: tokoList.length,
            itemBuilder: (context, index) {
              final toko = tokoList[index];
              return Padding(
                padding: const EdgeInsets.only(left: 1, right: 1),
                child: ProductCard(
                  imageUrl: toko.gambar,
                  rating: toko.rating,
                  restaurantName: toko.nama,
                  distance: '${toko.jarak} km',
                  estimatedTime: toko.waktu,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TokoPageUser(tokoData: toko),
                      ),
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

  Widget _buildZeflashSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Zeflash', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FlashsalePage()),
          );
        }),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Produk>>(
            future: _flashSaleService.getFlashSaleProdukByTime(
              getCurrentFlashSaleIndex(),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: zelow));
              }
              if (snapshot.hasError) {
                print('Zeflash error: ${snapshot.error}');
                return Center(child: Text('Gagal memuat produk.'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Tidak ada produk tersedia.'));
              }

              final produkList = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.only(left: 8, right: 8),

                scrollDirection: Axis.horizontal,
                itemCount: produkList.length,
                itemBuilder: (context, index) {
                  final produk = produkList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1),
                    child: FlashCard(
                      imageUrl: produk.gambar,
                      title: produk.nama,
                      price: currencyFormatter.format(produk.harga * 0.8),
                      stock: produk.stok,
                      sold: produk.terjual,
                      onTap: () {
                        final flashSaleProduk = produk.copyWith(
                          isFlashSale: true,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ProductInfoPage(
                                  productData: flashSaleProduk,
                                  tokoData: flashSaleProduk.toko!,
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRekomendasiSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Rekomendasi Untukmu',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          FutureBuilder<List<Toko>>(
            future: _tokoService.getAllTokoRandom(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print(
                  "Error fetching Rekomendasi toko list: ${snapshot.error}",
                );
                return const Center(child: Text('Gagal memuat data toko.'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Tidak ada toko tersedia.'));
              }

              final tokoList = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: tokoList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final toko = tokoList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: DisplayCard(
                      imageUrl: toko.gambar,
                      restaurantName: toko.nama,
                      description: toko.deskripsi,
                      rating: toko.rating,
                      distance: '${toko.jarak} km',
                      estimatedTime: toko.waktu,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TokoPageUser(tokoData: toko),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SliderWidget(),
              ),

              Transform.translate(
                offset: const Offset(0, -25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: "Lagi pengen makan apa?",
                        prefixIcon: Icon(Icons.search, color: zelow),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxButton(
                      icon: Icons.location_on,
                      text: "Terdekat",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DisplayPage(
                                  pageTitle: "Terdekat",
                                  fetchType: "terdekat_full",
                                ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    BoxButton(
                      icon: Icons.star,
                      text: "Paling Laris",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DisplayPage(
                                  pageTitle: "Paling Laris",
                                  fetchType: "paling_laris_full",
                                ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    BoxButton(
                      icon: Icons.food_bank_outlined,
                      text: "Rekomendasi",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DisplayPage(
                                  pageTitle: "Semua Rekomendasi",
                                  fetchType: "rekomendasi_full",
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              _buildZeflashSection(),
              const SizedBox(height: 4),

              _buildSectionTitle(context, 'Terdekat', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => DisplayPage(
                          pageTitle: "Terdekat",
                          fetchType: "terdekat_full",
                        ),
                  ),
                );
              }),
              _buildTokoHorizontal(
                _tokoService.getAllTokoTerdekat(),
                "terdekat",
              ),

              _buildRekomendasiSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 0),
    );
  }
}
