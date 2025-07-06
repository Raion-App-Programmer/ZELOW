import 'package:flutter/material.dart';
import 'package:zelow/pages/user/package_selection_page.dart';

class PromotionOptionPage extends StatelessWidget {
  const PromotionOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Promo",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
      ),
      body: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 48),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                 MaterialPageRoute(builder: (context) => PackageSelectionPage())
                );
            },
            child: Center(
            child: 
            Container(
            height: 112.0,
            width: 348.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff06C474),
                  Color(0xff035E38)
                ],
              ),
            ),
            child: Center(
              child: Text("Promo Iklan", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)),
            )
          ),
          ),
          ),
          SizedBox(height: 14),
          InkWell(
            onTap: () {},
            child: 
          Center(
            child: 
            Container(
            height: 112.0,
            width: 348.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff06C474),
                  Color(0xff035E38)
                ],
              ),
            ),
            child: Center(
              child: Text("Diskon", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)),
            )
          ),
          )
          ),
        ],
      ),
    );
  }
}
