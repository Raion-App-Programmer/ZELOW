import 'dart:math';

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
                DummyStok()
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

class DummyStok extends StatefulWidget {
  const DummyStok({super.key});

  @override
  State<DummyStok> createState() => _DummyStokState();
}

class _DummyStokState extends State<DummyStok> {
  int _currentStock = 0;
  bool _isAvailable = true;

  @override
  void initState() {
    super.initState();
    _currentStock = 0;
  }

  void increaseStock() {
    setState(() {
      _currentStock++;
    });
  }
  void decreaseStock() {
   if (_currentStock > 0) {
    setState(() {
      _currentStock--;
    });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFEFEFE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xffE6E6E6),
            width: 2,
            ),
        ),
        child: 
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueGrey
                    ),
                    width: 94.30,
                    height: 90,
                  ),
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    'Nasi Padang saus tiram',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                    ),
                    Text(
                      'RP15.000',
                      style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '$_currentStock | Tersedia',
                          style: greenTextStyle.copyWith(
                            wordSpacing: 4,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 20),
                        // increment and decrement button
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff06C474)),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                // decrement button
                                GestureDetector(
                                  onTap: decreaseStock,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: _currentStock > 0 ? Color(0xff06C474) : Color(0xffE6E6E6),
                                      ),
                                    ),
                                  ),
                                // current stock
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '$_currentStock',
                                    style: greenTextStyle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                // increment button
                                GestureDetector(
                                  onTap: increaseStock,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Color(0xff06C474),
                                  ),
                                ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 2,),
            Row(
              children: [
                Switch(
                  value: _isAvailable,
                  onChanged: (bool value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                  activeColor: Colors.green,
                  thumbColor: WidgetStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white; 
                      }
                      return Colors.white;
                    },
                  ),
            ),
            Text(
              'Tampilkan',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
          ],
      ),
      ),
    );
  }
}