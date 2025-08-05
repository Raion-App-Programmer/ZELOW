import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:zelow/pages/umkm/ulasan_page.dart';
import 'package:zelow/components/umkm_navbar.dart';

class HomePageUmkm extends StatefulWidget {
  const HomePageUmkm({super.key});

  @override
  State<HomePageUmkm> createState() => _HomePageUmkmState();
}

class _HomePageUmkmState extends State<HomePageUmkm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: MediaQuery.of(context).size.height * 0.001),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric( 
          vertical: MediaQuery.of(context).size.height * 0.06,
          horizontal: MediaQuery.of(context).size.width * 0.035,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hai, Ocha!",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Text(
                  "Geprek Opah - Malang",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                ),
                SizedBox(width: 5),
                Image.asset('assets/images/VectorLocation.png'),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04,),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.035,
              ),
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF06C474),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/icon_wallet.svg'),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Saldo Penjual",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "IDR",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "5.570.000",
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 118,
                        height: 23,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE6F9F1),
                            foregroundColor: Color(0xFF06C474),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 2,
                            ),
                          ),

                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/icon_money.svg'),
                              SizedBox(width: 12),
                              Text(
                                "Tarik Saldo",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      SizedBox(
                        width: 118,
                        height: 23,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/laporan');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE6F9F1),
                            foregroundColor: Color(0xFF06C474),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: 23,
                              vertical: 2,
                            ),
                          ),

                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_laporan.svg',
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Laporan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //INFO PEMBARUAN SALDO NYA
            Container(
              width: MediaQuery.of(context).size.width,
              height: 27,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.035,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A383838),
                    offset: Offset(0, 5.5),
                    blurRadius: 7.5,
                  ),
                ],
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(color: Color(0xFFE6E6E6), width: 1),
              ),
              child: Text(
                "Terakhir diperbarui: 26 Januari 2025, 09:30",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF676767),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/stok');
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Color(0xFF06C474),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      // bercak putih
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            center: Alignment.topLeft,
                            radius: 0.85,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.0, 0.85],
                          ),
                        ),
                      ),

                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            center: Alignment.bottomRight,
                            radius: 0.85,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.0, 0.85],
                          ),
                        ),
                      ),

                      // icon, text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              badges.Badge(
                                position: badges.BadgePosition.topEnd(
                                  top: -1.5,
                                  end: 1.5,
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: Color(0xFFE23A3A),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                badgeContent: Text(
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                child: SvgPicture.asset(
                                  'assets/images/icon_cart.svg',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Stok',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Color(0xFF06C474),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      // bercak putih nya
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            center: Alignment.topLeft,
                            radius: 0.85,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.0, 0.85],
                          ),
                        ),
                      ),

                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            center: Alignment.bottomRight,
                            radius: 0.85,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.0, 0.85],
                          ),
                        ),
                      ),

                      // icon, text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/icon_dollarcoin.svg'),
                          Text(
                            'Promosi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    (Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UlasanPage()),
                    ));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Color(0xFF06C474), // warna hijau dari Figma
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      // bercak putih nya
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            center: Alignment.topLeft,
                            radius: 0.85,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.0, 0.85],
                          ),
                        ),
                      ),

                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            center: Alignment.bottomRight,
                            radius: 0.85,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.0),
                            ],
                            stops: [0.0, 0.85],
                          ),
                        ),
                      ),

                      // icon, text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/icon_star.svg'),
                          Text(
                            'Ulasan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Promosi Terbaru",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 17),
            Image.asset('assets/images/paket_ramadhan.png', height: 194),

            SizedBox(height: MediaQuery.of(context).size.height*0.047),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 46,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Color(0xFFE6E6E6), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pusat Bantuan",
                    style: TextStyle(
                      fontFamily: 'R.font.nunito',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/images/arrow-left.png'),
                  ),
                ],
              ),
            ),

           
          ],
          
        ),
        
      ),
      bottomNavigationBar:  NavbarBottomUMKM(selectedItem: 0),
    );
  }
}
