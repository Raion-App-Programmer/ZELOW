// import 'package:flutter/material.dart';

// class FlashSaleTabs extends StatefulWidget {
//   final Function(int) onTabSelected; // Callback saat tab dipilih

//   const FlashSaleTabs({super.key, required this.onTabSelected});

//   @override
//   State<FlashSaleTabs> createState() => _FlashSaleTabsState();
// }

// class _FlashSaleTabsState extends State<FlashSaleTabs> {
//   int _selectedIndex = 0;

//   final List<Map<String, String>> _tabs = [
//     {"time": "09.00", "status": "Sedang Berlangsung"},
//     {"time": "12.00", "status": "Akan Datang"},
//     {"time": "18.00", "status": "Akan Datang"},
//     {"time": "00.00", "status": "Besok"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 80,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _tabs.length,
//         itemBuilder: (context, index) {
//           bool isSelected = _selectedIndex == index;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedIndex = index;
//               });
//               widget.onTabSelected(index); // Kirim indeks tab ke HomePage
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 children: [
//                   Text(
//                     _tabs[index]["time"]!,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isSelected ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                   Text(
//                     _tabs[index]["status"]!,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: isSelected ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                   if (isSelected) // Garis bawah hanya untuk tab aktif
//                     Container(
//                       margin: const EdgeInsets.only(top: 4),
//                       height: 3,
//                       width: 30,
//                       color: Colors.black,
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlashSaleTabs extends StatefulWidget {
  final Function(int) onTabSelected;

  const FlashSaleTabs({super.key, required this.onTabSelected});

  @override
  State<FlashSaleTabs> createState() => _FlashSaleTabsState();
}

class _FlashSaleTabsState extends State<FlashSaleTabs> {
  int _selectedIndex = 0;

  // Rentang flash sale
  final List<Map<String, dynamic>> _flashSaleTimes = [
    {"time": "00.00", "start": 0, "end": 9},
    {"time": "09.00", "start": 9, "end": 12},
    {"time": "12.00", "start": 12, "end": 18},
    {"time": "18.00", "start": 18, "end": 24},
  ];

  List<Map<String, String>> _tabs = [];

  @override
  void initState() {
    super.initState();
    _initializeTabs();
  }

  void _initializeTabs() {
    final now = DateTime.now();
    final currentHour = now.hour;

    // Tentukan indeks waktu yang sedang berlangsung
    int activeIndex = _flashSaleTimes.indexWhere(
      (item) => currentHour >= item["start"] && currentHour < item["end"],
    );

    if (activeIndex == -1) activeIndex = 0;

    List<Map<String, String>> reorderedTabs = [];

    // Tambah tab 'berlangsung'
    reorderedTabs.add({
      "time": _flashSaleTimes[activeIndex]["time"],
      "status": "Berlangsung",
    });

    // Tambah tab 'akan datang' untuk waktu setelah aktif
    for (int i = 1; i < 4; i++) {
      int nextIndex = (activeIndex + i) % 4;
      final nextTime = _flashSaleTimes[nextIndex]["time"];
      final status =
          (nextIndex > activeIndex)
              ? "Akan Datang"
              : "Besok"; // jika sudah melingkar ke awal
      reorderedTabs.add({"time": nextTime, "status": status});
    }

    setState(() {
      _tabs = reorderedTabs;
      _selectedIndex = 0; // default ke tab pertama yang sedang berlangsung
    });

    // Kirim indeks awal ke parent
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTabSelected(0);
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth * 0.25;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: SizedBox(
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
                widget.onTabSelected(index);
              },
              child: SizedBox(
                width: tabWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    if (isSelected)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 70,
                        color: Colors.grey,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
