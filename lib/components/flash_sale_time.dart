import 'package:flutter/material.dart';

class FlashSaleTabs extends StatefulWidget {
  final Function(int) onTabSelected; // Callback saat tab dipilih

  const FlashSaleTabs({super.key, required this.onTabSelected});

  @override
  State<FlashSaleTabs> createState() => _FlashSaleTabsState();
}

class _FlashSaleTabsState extends State<FlashSaleTabs> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _tabs = [
    {"time": "09.00", "status": "Sedang Berlangsung"},
    {"time": "12.00", "status": "Akan Datang"},
    {"time": "18.00", "status": "Akan Datang"},
    {"time": "00.00", "status": "Besok"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTabSelected(index); // Kirim indeks tab ke HomePage
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    _tabs[index]["time"]!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  Text(
                    _tabs[index]["status"]!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  if (isSelected) // Garis bawah hanya untuk tab aktif
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 3,
                      width: 30,
                      color: Colors.black,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
