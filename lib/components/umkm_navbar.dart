import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarBottomUMKM extends StatefulWidget {
  final int selectedItem;

  const NavbarBottomUMKM({Key? key, required this.selectedItem})
    : super(key: key);
  @override
  State<NavbarBottomUMKM> createState() => _NavbarBottomUMKMState();
}

class _NavbarBottomUMKMState extends State<NavbarBottomUMKM> {
  int _currentIndex = 0;

  void changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home_page_umkm');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/...');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/...');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/...');
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x1A383838),
              offset: Offset(0, -4),
              blurRadius: 12,
            ),
          ],
        ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: white,
        items: <BottomNavigationBarItem>[
           BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/Home.svg'),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/lets-icons_shop.svg'),
                label: 'Toko Saya',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/Chat.svg'),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/images/icon_profil.svg'),
                label: 'Profil',
              ),
        ],
        selectedItemColor: zelow,
        unselectedItemColor:  Color(0x80929292),
        selectedLabelStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Color(0xFF06C474),
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Color(0x80929292),
            ),
        currentIndex: widget.selectedItem,
        onTap: changeSelectedNavBar,
      ),
    );
  }
}
