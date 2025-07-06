import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'income_information.dart';

class cardIncome extends StatelessWidget {
  final int qris;
  final int other;
  final int layanan;
  final int pajak;
  final String title;
  final DateTime displayDate;
  final Color? totalColor;
  final String? icon;


  const cardIncome({
    super.key,
    required this.qris,
    required this.other,
    required this.layanan,
    required this.pajak,
    required this.title,
    required this.displayDate,
    required this.totalColor,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    final formatterCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    final formatterCostCurrency = NumberFormat.currency(locale: 'id_ID', symbol: '-IDR ', decimalDigits: 0);

    final total = qris + other - layanan - pajak;

    return Container(
      width: 364,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 18),
              Text(title.split(' ')[0],
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Nunito')),
              const Text(' '),
              Text(
                title.split(' ').sublist(1).join(' '),
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Nunito', color: Color(0xFF06C474)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3, right: 20, bottom: 3, left: 20),
            child: dateInformation(displayDate: displayDate,showTime: false),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, right: 20, bottom: 3, left: 20),
            child: Text('Pendapatan Kotor',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Nunito')),
          ),
          _infoRow('Pembayaran QRIS', formatterCurrency.format(qris)),
          _infoRow('Pembayaran Lainnya', formatterCurrency.format(other)),
          const Padding(
            padding: EdgeInsets.only(top: 13, right: 20, bottom: 3, left: 20),
            child: Text('Potongan Biaya',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Nunito')),
          ),
          _infoRow('Biaya Layanan', formatterCostCurrency.format(layanan)),
          _infoRow('Biaya Pajak', formatterCostCurrency.format(pajak)),
          Padding(
            padding: const EdgeInsets.only(top: 22, right: 20, bottom: 25, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pendapatan Bersih',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Nunito')),
                Row(
                  children: [
                    if(icon != null)
                      Image.asset(icon!, height: 17, width: 17),
                    const SizedBox(width: 5),
                    Text(formatterCurrency.format(total),
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, fontFamily: 'Nunito', color: totalColor ?? Colors.black)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Nunito')),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Nunito')),
        ],
      ),
    );
  }
}
