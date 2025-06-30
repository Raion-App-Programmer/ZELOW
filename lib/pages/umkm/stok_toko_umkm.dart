import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class StokTokoUmkm extends StatelessWidget {
  const StokTokoUmkm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text(
          'Stok di ZeUp',
          style: whiteTextStyle.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}