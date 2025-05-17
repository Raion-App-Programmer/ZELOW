import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/whatsApp.dart';

import 'constant.dart';

class chatList extends StatelessWidget{
  final String imageUrl;
  final String name;

  const chatList({
    Key? key,
    required this.imageUrl,
    required this.name,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        bukaWhatsapp(nomor: '081806615372', pesan: 'h-halo saya ingin bertanya 👉👈');
      },
      child: Column(
        children: [
          const SizedBox(height: 2),
      Container(
        width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 0.5,
            spreadRadius: 0.25,
            offset: Offset(0, 0.125),
          ),
        ]
      ),
      child: Row(
      children: [
        SizedBox(width: 15,),
        ClipRRect(
      borderRadius: BorderRadius.circular(40),
    child: Image.asset(imageUrl, height: 70, width: 70, fit: BoxFit.cover
    ),
      ),
      const SizedBox(width: 45, height: 60,),

        Expanded(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
        Text(name, style: blackTextStyle.copyWith(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito',
    ),
    ),
          ],
    ),
        )],
      ),

      ),
    ]
      )
    );
  }
}