import 'package:flutter/material.dart';
import 'package:zelow/components/chat_list.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';
import 'package:zelow/components/product_card_horizontal.dart';


class ChatPage extends StatelessWidget{
  const ChatPage({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: (){
        Navigator.pop(context);
      },
      ),
      title: Text('Chat', textAlign: TextAlign.center, style: whiteTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width * 0.05,
        fontWeight: FontWeight.bold)),
      centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics() ,
            itemBuilder: (context, index){
              return chatList(imageUrl: 'assets/images/karina-aespa.jpg', name: 'Warung Ayam Mbak Karina');
            }
        ),
        )
      ),
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 3),

    );
  }
}