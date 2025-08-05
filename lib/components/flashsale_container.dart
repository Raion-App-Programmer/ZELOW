import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:intl/intl.dart';
import 'package:zelow/utils/format_mata_uang.dart';

class FoodSaleCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback onBuyPressed;

  const FoodSaleCard({
    Key? key,
    required this.produk,
    required this.onBuyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = (produk.terjual / produk.stok).clamp(0.0, 1.0);

    const Color greenHex = Color(0xFF06C474);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 2,
            spreadRadius: 0.4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  produk.gambar,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: greenHex,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '-20%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.nama,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      '${produk.jumlahPembelian} Terjual | Disukai oleh ${produk.jumlahDisukai}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      FormatMataUang.formatRupiah(produk.harga * 0.8, 0),
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: greenHex,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      FormatMataUang.formatRupiah(produk.harga, 0),
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.red.withOpacity(0.25),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.red,
                                ),
                                minHeight: 20,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${produk.terjual} TERJUAL',
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onBuyPressed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: greenHex,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Beli',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
