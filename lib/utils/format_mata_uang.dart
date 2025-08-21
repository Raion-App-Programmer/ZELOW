import 'package:intl/intl.dart';

class FormatMataUang {
  static String formatRupiah(dynamic angka, int digitDesimal) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: digitDesimal,
    );
    return currencyFormatter.format(angka);
  }
}