import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CartBottomNavBar extends StatefulWidget {
  const CartBottomNavBar({super.key});

  @override
  State<CartBottomNavBar> createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, -3), // shadow ke atas
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -15, end: -12),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Color(0xff06C474),
                    padding: EdgeInsets.all(3.2),
                  ),
                  badgeContent: Text(
                    '4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  child: Image.asset(
                    'assets/images/keranjangKu-icon.png',
                    width: 25,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 36, right: 8),
                    child: Text(
                      "Rp40.000",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff06C474),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        alignment: Alignment.center,
                        height: 44,
                        width:double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff06C474),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
