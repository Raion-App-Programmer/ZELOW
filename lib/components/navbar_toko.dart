
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class NavbarToko extends StatefulWidget {
  final int selectedItem;
  const NavbarToko({super.key, required this.selectedItem});

  @override
  State<NavbarToko> createState() => _NavbarTokoState();
}

class _NavbarTokoState extends State<NavbarToko> {
  int _currentIndex = 0;

  void changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home_page_user');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/tokosaya');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/chat');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profilpenjualumkm');
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
          icon:  Icon(Icons.storefront_rounded),
          label: 'Toko Saya',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: zelow,
      unselectedItemColor: Colors.black26,
      currentIndex: widget.selectedItem,
      onTap: changeSelectedNavBar,
    );
  }
}
