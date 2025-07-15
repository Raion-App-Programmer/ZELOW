import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/user/home_page_user.dart';
import 'package:zelow/pages/user/pesanan_page.dart';
import 'package:zelow/pages/user/flashsale_page.dart';
import 'package:zelow/pages/user/chat_page.dart';
import 'package:zelow/pages/user/profile_page.dart';

class BottomNav extends StatefulWidget {
  final int selectedItem;
  const BottomNav({super.key, required this.selectedItem});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  void changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePageUser()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PesananPage(orders: [])),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FlashsalePage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const chatPage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'Pesanan Saya',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Flash Sale'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedItemColor: zelow,
      unselectedItemColor: Colors.black26,
      currentIndex: widget.selectedItem,
      onTap: changeSelectedNavBar,
    );
  }
}
