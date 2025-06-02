import 'package:flutter/material.dart';
import 'package:zelow/components/akandatang_card.dart';
import 'dart:async';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/flash_sale_time.dart';
import 'package:zelow/components/flashsale_container.dart';
import 'package:zelow/components/flassale_button.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/pages/user/infoproduk_page.dart';
import 'package:zelow/pages/user/keranjang_page.dart';
import 'package:zelow/pages/user/search_page.dart';

class FlashsalePage extends StatefulWidget {
  const FlashsalePage({super.key});

  @override
  State<FlashsalePage> createState() => _FlashsalePageState();
}

class _FlashsalePageState extends State<FlashsalePage> {
  int _currentTab = 0;
  int _selectedCategory = 0;
  int _selectedTab = 0;
  Duration _remainingTime = const Duration(hours: 1);

  // hitung waktu flash sale tersisa
  Duration getRemainingFlashSaleTime() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final List<Map<String, DateTime>> timeSlots = [
      {
        'start': today.add(const Duration(hours: 0)),
        'end': today.add(const Duration(hours: 9)),
      },
      {
        'start': today.add(const Duration(hours: 9)),
        'end': today.add(const Duration(hours: 12)),
      },
      {
        'start': today.add(const Duration(hours: 12)),
        'end': today.add(const Duration(hours: 18)),
      },
      {
        'start': today.add(const Duration(hours: 18)),
        'end': today.add(const Duration(days: 1)), // sampai 00:00 besok
      },
    ];

    for (var slot in timeSlots) {
      final start = slot['start']!;
      final end = slot['end']!;
      if (now.isAfter(start) && now.isBefore(end)) {
        return end.difference(now);
      }
    }

    return timeSlots[0]['end']!.difference(now);
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentTab = index;
      _selectedTab = index;
    });
  }

  final List<Map<String, dynamic>> _categories = [
    {"icon": Icons.flash_on, "text": "All"},
    {"icon": Icons.access_time, "text": "Segera \nHabis"},
    {"icon": Icons.local_attraction, "text": "Ramadhan \nSale"},
    {"icon": Icons.location_on, "text": "Terdekat"},
    {"icon": Icons.sell_rounded, "text": "Termurah"},
  ];

  @override
  void initState() {
    super.initState();

    _remainingTime = getRemainingFlashSaleTime();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        setState(() {
          _remainingTime = getRemainingFlashSaleTime();
        });
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset('assets/images/Zeflash.png', height: 30),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: CircleAvatar(
                  backgroundColor: white,
                  child: IconButton(
                    icon: Icon(Icons.notifications, color: zelow),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  backgroundColor: white,
                  child: IconButton(
                    icon: Icon(Icons.shopping_bag_rounded, color: zelow),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KeranjangKu()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: zelow, width: 1),
              ),
              child: TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Lagi pengen makan apa',
                  hintStyle: greyTextStyle,
                  prefixIcon: Icon(Icons.search, color: zelow),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 11),
                ),
              ),
            ),
          ),
          FlashSaleTabs(onTabSelected: _onTabSelected),
          SizedBox(
            height: 80,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: List.generate(
                    _categories.length,
                    (index) => FlashSaleBoxButton(
                      icon: _categories[index]["icon"],
                      text: _categories[index]["text"],
                      isSelected: _selectedCategory == index,
                      onPressed: () {
                        setState(() {
                          _selectedCategory = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  "BERAKHIR DALAM ",
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDuration(_remainingTime),
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(1),
              itemCount:
                  (_selectedTab == 1 || _selectedTab == 2 || _selectedTab == 3)
                      ? 3
                      : 5,
              itemBuilder: (context, index) {
                if (_selectedTab == 1 ||
                    _selectedTab == 2 ||
                    _selectedTab == 3) {
                  return const AkandatangCard();
                } else {
                  return FoodSaleCard(
                    sold: (index + 1) * 5,
                    maxStock: 50,
                    onBuyPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductInfoPage(
                                productData: {
                                  'id': (index + 1).toDouble(),
                                  'title':
                                      'Masakan Padang Roda Dua, Bendungan Sutami',
                                  'imageUrl': 'https://picsum.photos/200/200',
                                  'rating': 4.5,
                                  'reviewCount': 688.toDouble(),
                                  'likeCount': 420.toDouble(),
                                  'price': 10000.toDouble(),
                                  'originalPrice': 12500.toDouble(),
                                  'distance': '1.2 km',
                                  'discount': '20%',
                                  'sold': ((index + 1) * 5).toDouble(),
                                  'reviews': [
                                    {
                                      'name': 'Nana Mirdad',
                                      'imageUrl':
                                          'https://example.com/avatar1.jpg',
                                      'rating': 5.0,
                                    },
                                    {
                                      'name': 'Budi Santoso',
                                      'imageUrl':
                                          'https://example.com/avatar2.jpg',
                                      'rating': 4.0,
                                    },
                                  ],
                                },
                              ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 2),
    );
  }
}
