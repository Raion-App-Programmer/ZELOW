import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/navbar_toko.dart';

class TokoSayaPage extends StatefulWidget {
  const TokoSayaPage({Key? key}) : super(key: key);

  @override
  _TokoSayaPageState createState() => _TokoSayaPageState();
}

class _TokoSayaPageState extends State<TokoSayaPage> {
  bool isOpen = false; // Track whether the store is open or closed

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: zelow,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0), // Atur padding atas
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 35.0), // Atur padding atas
            child: Text(
              'Toko Saya',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3)
            )
            ],
          ),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 120,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/naspad.jpg',
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20), // Spacing between image and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Icon(
                                Icons.storefront_rounded, size: 40, color: zelow,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 200), // Set your max width here
                                child: Text(
                                  'Masakan Padang Roda Dua, Bendungan Sutami',
                                  style: TextStyle(color: Colors.black, fontFamily: 'nunito'),
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Merchant ID : ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
              ),
          SizedBox(height: 50),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Container(
              width: 340,
              height: 130,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 70, // Half of Container height (100)
                    child: Container(
                      decoration: BoxDecoration(
                        color: zelow, // Your desired color
                        borderRadius: BorderRadius.all(
                          Radius.circular(12)
                        ),
                      ),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2
                                      )
                                    ),
                                    child: Icon(
                                      Icons.circle, size: 20,
                                      color: isOpen ? Colors.green : Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 200), // Set your max width here
                                      child: Text(
                                        isOpen ? 'Buka' : 'Tutup',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  isOpen ? 'Dibuka sampai anda tutup kembali' : 'Ditutup sampai anda buka kembali',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 200), // Set your max width here
                          child: Text(
                            isOpen ? 'Tekan “Tutup resto“ untuk tidak menerima pesanan.' : 'Tekan “Buka resto” untuk mulai terima pesanan lagi.',
                            style: TextStyle(color: Colors.grey),
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 25),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 95,
                            decoration: BoxDecoration(
                              color: zelow,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                  isOpen ? 'Buka Resto' : 'Buka Resto',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      'Informasi Toko',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 7
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/edittokosaya');
                      },
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 17),
              child: Container(
                height: 153,
                width: 353,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nama', style: TextStyle(fontSize: 14)),
                        Icon(Icons.arrow_forward_rounded, color: zelow)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kontak', style: TextStyle(fontSize: 14)),
                        Icon(Icons.arrow_forward_rounded, color: zelow)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Alamat', style: TextStyle(fontSize: 14)),
                        Icon(Icons.arrow_forward_rounded, color : zelow)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rekening Pencairan', style: TextStyle(fontSize: 14)),
                        Icon(Icons.arrow_forward_rounded, color : zelow)
                      ],
                    )
                  ],

                ),
              ),
            )
        )
        ],
      ),
      bottomNavigationBar: const NavbarToko(selectedItem: 1),
    );
  }
}
