import 'package:flutter/material.dart';
import 'package:zelow/components/rating_linear_indicator.dart';
import 'package:zelow/components/rating_bar_indicator.dart';
import 'package:zelow/components/review_user.dart';
import 'package:zelow/pages/umkm/home_umkm_page.dart';

class UlasanPage extends StatefulWidget {
  const UlasanPage({super.key});

  @override
  State<UlasanPage> createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff06C474),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.028),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, 
              MaterialPageRoute(builder: (context)=> HomePageUmkm()));
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.028),
          child: Text(
            "Ulasan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding:EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.048, left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.049),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "4.5",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'R.font.nunito',
                      ),
                    ),
                    RatingIcon(rating: 4.5),

                    SizedBox(height: 8),
                    Text(
                      '(260 Penilaian)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              
                Expanded(
                  child: Column(
                    children: [
                      RatingLinear(text: '5', rate: 0.92),
                      RatingLinear(text: '4', rate: 0.72),
                      RatingLinear(text: '3', rate: 0.29),
                      RatingLinear(text: '2', rate: 0.09),
                      RatingLinear(text: '1', rate: 0.03),
                    ],
                  ),
                ),
              ],
            ),

            //ULASAN NYA
            SizedBox(height: MediaQuery.of(context).size.height * 0.048),
            Expanded(child: UserReview())
           
            
          ],
        ),
      ),
    );
  }
}
