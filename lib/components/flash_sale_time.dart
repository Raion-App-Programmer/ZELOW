import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class FlashSaleTabs extends StatefulWidget {
  final Function(int) onTabSelected;

  const FlashSaleTabs({super.key, required this.onTabSelected});

  @override
  State<FlashSaleTabs> createState() => _FlashSaleTabsState();
}

class _FlashSaleTabsState extends State<FlashSaleTabs> {
  int _selectedIndex = 0;

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

    int activeIndex = _flashSaleTimes.indexWhere(
      (item) => currentHour >= item["start"] && currentHour < item["end"],
    );

    if (activeIndex == -1) activeIndex = 0;

    List<Map<String, String>> reorderedTabs = [];

    reorderedTabs.add({
      "time": _flashSaleTimes[activeIndex]["time"],
      "status": "Berlangsung",
    });

    for (int i = 1; i < 4; i++) {
      int nextIndex = (activeIndex + i) % 4;
      final nextTime = _flashSaleTimes[nextIndex]["time"];
      final status = (nextIndex > activeIndex) ? "Akan Datang" : "Besok";
      reorderedTabs.add({"time": nextTime, "status": status});
    }

    setState(() {
      _tabs = reorderedTabs;
      _selectedIndex = 0;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTabSelected(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth * 0.24;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 70,
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
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? Colors.black : Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _tabs[index]["status"]!,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isSelected)
                      Container(
                        height: 2,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
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
