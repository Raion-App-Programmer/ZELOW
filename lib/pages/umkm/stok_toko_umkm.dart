import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/umkm/tambah_produk_umkm.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
              ],
            ),
          ),
          TambahProduk(),
          SafeArea(child: Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 15)))
        ],
      )
    );
  }
}

class TambahProduk extends StatelessWidget {
  const TambahProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            fixedSize: const Size(353, 44),
            backgroundColor: Color(0xff06C474)
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahProdukUmkm(),
              )
            );
          },
          child: Text(
            'Tambah Produk',
            textAlign: TextAlign.center,
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16
            ),
          )
        )
      ],
    );
  }
}