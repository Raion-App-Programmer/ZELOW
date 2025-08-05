import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:intl/intl.dart';
import 'package:zelow/utils/format_mata_uang.dart';

class AkandatangCard extends StatelessWidget {
  final Produk produk;

  const AkandatangCard({Key? key, required this.produk}) : super(key: key);

  void _showReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: black.withOpacity(0.3),
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notifications_active, color: white, size: 20),
                const SizedBox(height: 8),
                Text(
                  'Pengingat akan dikirimkan Anda 5 menit sebelum Flash Sale dimulai.',
                  textAlign: TextAlign.center,
                  style: whiteTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color greenHex = Color(0xFF06C474);
    const Color buttonBg = Color(0xFFE6F9F1);

    return GestureDetector(
      onTap: () => _showReminderDialog(context),
      child: Container(
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${produk.jumlahPembelian} Terjual | Disukai oleh ${produk.jumlahDisukai}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(produk.harga * 0.8),
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: greenHex,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(produk.harga),
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () => _showReminderDialog(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: buttonBg,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        minimumSize: const Size(0, 28),
                        side: const BorderSide(color: greenHex),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Ingatkan Saya',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: greenHex,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
