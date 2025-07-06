import 'package:flutter/material.dart';
import 'package:zelow/components/chat_list.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/product_card_horizontal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class chatPage extends StatelessWidget {
  const chatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chat',
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('toko').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final tokoList = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: tokoList.length,
            itemBuilder: (context, index) {
              final toko = tokoList[index];
              final nama = toko['nama'] ?? 'Tanpa Nama';
              final nomor = toko['nomor'] ?? '';
              final gambar = 'assets/images/picture-profile-toko.jpg';

              return chatList(
                imageUrl: gambar,
                name: nama,
                nomor: nomor,
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 3),
    );
  }
}
