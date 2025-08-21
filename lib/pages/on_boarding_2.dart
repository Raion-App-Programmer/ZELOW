import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/on_boarding_3.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/on_boarding_2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flash Sale & Surprise Bag',
                  style: blackTextStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Dapatkan diskon & surprise bag \ndengan harga makin terjangkau!',
                  style: greyTextStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/slide_image_2.png"),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnBoarding3()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Color(0xff06C474),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
