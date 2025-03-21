import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/navbar.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body:  Center(
        child: Text(
          'Coming Soon',
          style: greenTextStyle.copyWith(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(selectedItem: 3),
    );
  }
}
