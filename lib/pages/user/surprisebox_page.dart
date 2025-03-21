import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/surprisebox_card.dart';

class SurpriseBoxPage extends StatelessWidget {
  const SurpriseBoxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Surprise Box',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SurpirseCard(
             imageUrl: 'assets/images/naspad.jpg',
            restaurantName: 'Nasi Padang Roda Baru',
            description: 'Paket komplit dengan rendang dan sambal hijau',
            rating: 4.9,
            distance: '1 km',
            estimatedTime: '10 min',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
