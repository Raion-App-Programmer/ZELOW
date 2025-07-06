import 'package:flutter/material.dart';
import 'package:zelow/pages/user/payment_option_page.dart';

class PackageSelectionPage extends StatefulWidget {
  const PackageSelectionPage({super.key});

  @override
  State<PackageSelectionPage> createState() => _PackageSelectionPageState();
}

List<String> options = ['option 1', 'option 2'];

class _PackageSelectionPageState extends State<PackageSelectionPage> {
  String currentOption = options[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      BackButton(
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    Text('Promo Iklan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white))
                    ],
                  ),
                  SizedBox(
                    height: 32
                    ),
                    Container(
                      padding: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Tingkatkan Penjualan Bisnis Kuliner Anda dengan ZeUp! 🚀", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 9),
                          Text(
                            "Ingin restoran Anda lebih dikenal dan kebanjiran pesanan di GoFood? Saatnya naik level dengan ZeUp!", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Dengan strategi pemasaran yang tepat, bisnis Anda bisa tampil lebih menonjol di antara ribuan resto lainnya.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
                          ),
                          Text(
                            "1. Paket Iklan Termurah (Rp 50.000 - Rp. 150.000)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)
                          ),
                          SizedBox(height: 2),
                          Text(
                            "isi Paket:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)
                            ),
                          Text(
                            "✅ Listing Prioritas \n"
                            "✅ Highlight Produk \n"
                            "✅ 1x Push Notification per bulan    \n"
                            "✅ Analisis Performa Dasar"
                            , style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "2. Paket Iklan Menengah  (Rp 200.000 - Rp. 500.000)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 2),
                          Text(
                          "Isi Paket:\n"
                          "✅ Semua fitur dari Paket Basic\n"
                          "✅ 3x Push Notification per bulan\n"
                          "✅ Spot Iklan di Halaman Utama \n"
                          "✅ Promosi di Media Sosial\n"
                          "✅ Fitur Flash Sale",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        SizedBox(height: 4),
                        Text("Jangan biarkan restoran Anda tenggelam di tengah persaingan! Saatnya Naik Level dengan ZeUp dan buat bisnis Anda semakin berkembang! 🌟", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                        SizedBox(height: 12),
                        ListTile(
                          title: Text("Paket 1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          leading: Radio(value: options[0],
                           groupValue: currentOption,
                           onChanged: (selectedvalue){
                            setState(() => currentOption = selectedvalue!);
                            },
                            activeColor: Color(0xff06C474),),
                        ),
                        ListTile(
                          title: Text("Paket 2", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          leading: Radio(value: options[1],
                           groupValue: currentOption,
                           onChanged: (selectedvalue){
                            setState(() => currentOption = selectedvalue!);
                            },
                            activeColor: Color(0xff06C474),),
                        ),
                        SizedBox(height: 42)
                        ],
                      ),
                    ),
                    SizedBox(
                          height: 44,
                          width: 353,
                          child: ElevatedButton(onPressed: (){
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => PaymentOptionPage())
                            );
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff06C474),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                          ),
                        ),
                         child: Text("Beli", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                        )
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}