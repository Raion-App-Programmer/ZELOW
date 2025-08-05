import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/navbar_toko.dart';

class ProfilPenjualUmkmPage extends StatefulWidget {
  const ProfilPenjualUmkmPage({Key? key}) : super(key: key);

  @override
  _ProfilPenjualUmkmState createState() => _ProfilPenjualUmkmState();
}

class _ProfilPenjualUmkmState extends State<ProfilPenjualUmkmPage> {
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
              'Profil',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            Container(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    radius: 40,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Geprek_Opah', //username
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      'ochahahaha@gmail.com', //email
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Text(
                            'Edit Profil',
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left : 20, right :20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pengaturan Akun
                    Text(
                      'Pengaturan Akun',
                      style: TextStyle(
                        fontFamily: 'nunitobold',
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Alamat Saya', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Keamanan Akun', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    //Pengaturan Umum
                    Text(
                      'Pengaturan Umum',
                      style: TextStyle(
                          fontFamily: 'nunitobold',
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Pengaturan Chat', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Pengaturan Notifikasi', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Bahasa & Masukan', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    //Bantuan
                    Text(
                      'Bantuan',
                      style: TextStyle(
                          fontFamily: 'nunitobold',
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Bantuan Akun', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Kebijakan Zelow', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Rate Zelow', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.receipt_sharp, size: 20, color: zelow), // leading icon
                          SizedBox(width: 10),
                          Expanded(child: Text('Informasi Aplikasi', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16))),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey), // trailing icon
                        ],
                      ),
                    ),

                    SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                      },
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app, size: 20, color: Colors.grey), // leading icon
                          SizedBox(width: 10),
                          Text('Keluar', style: TextStyle(fontFamily: 'nunitobold', fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
      ),
      bottomNavigationBar: const NavbarToko(selectedItem: 3),
    );
  }
}
