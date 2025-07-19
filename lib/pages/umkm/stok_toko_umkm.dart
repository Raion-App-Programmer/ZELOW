import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/umkm/tambah_produk_umkm.dart';
import "package:zelow/services/produk_service.dart";
import 'package:zelow/models/produk_model.dart';

class StokTokoUmkm extends StatefulWidget {
  const StokTokoUmkm({super.key});

  @override
  State<StokTokoUmkm> createState() => _StokTokoUmkmState();
}

class _StokTokoUmkmState extends State<StokTokoUmkm> {
  final ProdukService _produkService = ProdukService();
  String? _UmkmId;

  @override
  void initState() {
    super.initState();
    _getCurrentUmkmId();
  }

  // function to get tokoId
  Future<void> _getCurrentUmkmId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _UmkmId = user.uid;
      });
    } else {
      print(
        'Error: User logged in is not an UMKM owner or user ID is not available.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zelow,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
            child:
                _UmkmId == null
                    ? const Center(child: CircularProgressIndicator())
                    : StreamBuilder<List<Produk>>(
                      stream: _produkService.getProdukByTokoStream(_UmkmId!),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print('StreamBuilder Error: ${snapshot.error}');
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'Tidak flutter ada produk ditemukan untuk toko ini',
                            ),
                          );
                        }

                        // kalau data
                        final List<Produk> produkList = snapshot.data!;
                        return ListView.builder(
                          itemCount: produkList.length,
                          itemBuilder: (context, index) {
                            final produk = produkList[index];
                            return ProdukListItem(produk: produk);
                          },
                        );
                      },
                    ),
          ),
          const TambahProduk(),
          const SafeArea(
            child: Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 15)),
          ),
        ],
      ),
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
            backgroundColor: Color(0xff06C474),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TambahProdukUmkm()),
            );
          },
          child: Text(
            'Tambah Produk',
            textAlign: TextAlign.center,
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class ProdukListItem extends StatelessWidget {
  final Produk produk;

  const ProdukListItem({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    final ProdukService _produkService = ProdukService();

    final String imageUrl = produk.gambar;
    final String title = produk.nama;
    final double price = produk.harga;
    final int stocks = produk.stok;
    final String produkId = produk.id;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xffE6E6E6), width: 2),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 94.30,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image:
                          imageUrl.isNotEmpty
                              ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                              : null,
                      color: imageUrl.isEmpty ? Colors.blueGrey : null,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'RP${price.toStringAsFixed(0)}',
                        style: greyTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            '$stocks | ${stocks > 0 ? 'Tersedia' : 'Tidak Tersedia'}',
                            style: (stocks > 0 ? greenTextStyle : greyTextStyle)
                                .copyWith(
                                  wordSpacing: 4,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xff06C474),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (stocks > 0) {
                                        await _produkService
                                            .decreaseProductStock(produkId, -1);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color:
                                            stocks > 0
                                                ? const Color(0xff06C474)
                                                : const Color(0xffE6E6E6),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      '$stocks',
                                      style: greenTextStyle.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await _produkService.updateProductStock(
                                        produkId,
                                        1,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Color(0xff06C474),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
