import 'package:flutter/material.dart';
import 'package:zelow/components/akandatang_card.dart';
import 'dart:async';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/flash_sale_time.dart';
import 'package:zelow/components/flashsale_container.dart';
import 'package:zelow/components/flassale_button.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/pages/user/keranjang_page.dart';
import 'package:zelow/pages/user/search_page.dart';
import 'package:zelow/services/flashsale_service.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/utils/time_slot_utils.dart';
import 'package:zelow/pages/user/infoproduk_page.dart';

List<Map<String, DateTime>> rotateSlots(
  List<Map<String, DateTime>> slots,
  int startIndex,
) {
  return [...slots.sublist(startIndex), ...slots.sublist(0, startIndex)];
}

class FlashsalePage extends StatefulWidget {
  const FlashsalePage({super.key});

  @override
  State<FlashsalePage> createState() => _FlashsalePageState();
}

late List<Map<String, DateTime>> rotatedSlots;
late List<int> rotatedToOriginalIndex;

class _FlashsalePageState extends State<FlashsalePage> {
  int _selectedCategory = 0;
  int _selectedTab = 0;
  Duration _remainingTime = const Duration(hours: 1);

  final FlashSaleService _flashSaleService = FlashSaleService();
  Future<List<Produk>>? _flashSaleProdukList;

  final List<Map<String, dynamic>> _categories = [
    {"icon": Icons.flash_on, "text": "Semua"},
    {"icon": Icons.access_time, "text": "Segera \nHabis"},
    {"icon": Icons.local_attraction, "text": "Ramadhan \nSale"},
    {"icon": Icons.location_on, "text": "Terdekat"},
    {"icon": Icons.sell_rounded, "text": "Termurah"},
  ];

  Duration getRemainingFlashSaleTime() {
    final now = DateTime.now();
    final slots = getTimeSlots();
    for (var slot in slots) {
      if (now.isAfter(slot['start']!) && now.isBefore(slot['end']!)) {
        return slot['end']!.difference(now);
      }
    }
    return slots[0]['end']!.difference(now);
  }

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

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
      _flashSaleProdukList = _flashSaleService.getFlashSaleProdukByTime(index);
      _remainingTime = getRemainingFlashSaleTime();
    });
  }

  @override
  void initState() {
    super.initState();

    final originalSlots = getTimeSlots();
    final currentIndex = getCurrentFlashSaleIndex();

    rotatedSlots = rotateSlots(originalSlots, currentIndex);
    rotatedToOriginalIndex = List.generate(
      rotatedSlots.length,
      (i) => (currentIndex + i) % originalSlots.length,
    );

    _selectedTab = 0;
    _remainingTime = getRemainingFlashSaleTime();
    _flashSaleProdukList = _flashSaleService.getFlashSaleProdukByTime(
      rotatedToOriginalIndex[_selectedTab],
    );

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime -= const Duration(seconds: 1);
        });
      } else {
        timer.cancel();

        final newIndex = getCurrentFlashSaleIndex();
        rotatedSlots = rotateSlots(originalSlots, newIndex);
        rotatedToOriginalIndex = List.generate(
          rotatedSlots.length,
          (i) => (newIndex + i) % originalSlots.length,
        );

        setState(() {
          _selectedTab = 0;
          _remainingTime = getRemainingFlashSaleTime();
          _flashSaleProdukList = _flashSaleService.getFlashSaleProdukByTime(
            rotatedToOriginalIndex[_selectedTab],
          );
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/Zeflash.png', height: 30),
        actions: [
          CircleAvatar(
            backgroundColor: white,
            child: IconButton(
              icon: Icon(Icons.notifications, color: zelow),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: white,
            child: IconButton(
              icon: Icon(Icons.shopping_bag_rounded, color: zelow),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => KeranjangKu()),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
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
                border: Border.all(color: zelow),
              ),
              child: TextField(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchPage()),
                    ),
                decoration: InputDecoration(
                  hintText: 'Lagi pengen makan apa?',
                  hintStyle: greyTextStyle,
                  prefixIcon: Icon(Icons.search, color: zelow),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 11),
                ),
              ),
            ),
          ),
          FlashSaleTabs(onTabSelected: _onTabSelected),
          const SizedBox(height: 4),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return FlashSaleBoxButton(
                  icon: category["icon"],
                  text: category["text"],
                  isSelected: _selectedCategory == index,
                  onPressed: () {
                    setState(() {
                      _selectedCategory = index;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
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
            child: FutureBuilder<List<Produk>>(
              future: _flashSaleProdukList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Gagal memuat data: ${snapshot.error}'),
                  );
                }

                final produkList = snapshot.data ?? [];
                final isOngoing =
                    rotatedToOriginalIndex[_selectedTab] ==
                    getCurrentFlashSaleIndex();

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 5),
                  itemCount: produkList.length,
                  itemBuilder: (context, index) {
                    final produk = produkList[index];
                    return isOngoing
                        ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => ProductInfoPage(productData: produk),
                              ),
                            );
                          },
                          child: FoodSaleCard(
                            produk: produk,
                            onBuyPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          ProductInfoPage(productData: produk),
                                ),
                              );
                            },
                          ),
                        )
                        : AkandatangCard(produk: produk);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 2),
    );
  }
}
