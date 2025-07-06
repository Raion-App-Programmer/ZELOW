import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:zelow/pages/user/payment_page.dart';

class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "image": Image(image: AssetImage("assets/images/mandiri.png")), // ganti dengan AssetImage jika pakai logo Mandiri
      "label": "Bank Mandiri",
    },
    {
      "image": Image(image: AssetImage("assets/images/bca.jpg")),
      "label": "Bank BCA",
    },
    {
      "image": Image(image: AssetImage("assets/images/bni.png")),
      "label": "Bank BNI",
    },
    {
      "image": Image(image: AssetImage("assets/images/visa.png")),
      "label": "VISA",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff06C474),
                Color(0xff035E38)
              ]
            )
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(padding: EdgeInsets.only(bottom: 48),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 44),
            for (int index = 0; index < paymentMethods.length; index++)
              _buildPaymentOption(index),
              Spacer(),
              SizedBox(
              height: 44,
              width: 353,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => PaymentPage())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff06C474),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)
                )
              ),
               child: Text("Submit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),))
              )
          ]
        ),
        )
        ),
      ),
    );
  }
  Widget _buildPaymentOption(int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 321,
        height: 92,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFFA1C45A) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 48,
              child: paymentMethods[index]['image']),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                paymentMethods[index]['label'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFA1C45A) : Colors.grey,
                shape: BoxShape.circle
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            )
          ],
        ),
      ),
    );
  }
}
