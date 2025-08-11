import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zelow/pages/user/pesanan_diproses_page.dart';
import 'package:zelow/services/pesanan_service.dart';
import 'package:zelow/services/keranjang_service.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;
  final double subtotal;
  final String selectedPayment;
  final String selectedSchedule;
  final String selectedBankName;

  const PaymentPage({
    Key? key,
    required this.orders,
    required this.subtotal,
    required this.selectedPayment,
    required this.selectedSchedule,
    required this.selectedBankName,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PesananService _pesananService = PesananService();
  final KeranjangService _keranjangService = KeranjangService();
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  late String _accountNumber;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _accountNumber = _generateAccountNumber(widget.selectedBankName);
  }

  String formatRupiah(num value) => "Rp${currencyFormatter.format(value)}";

  String _generateAccountNumber(String bankName) {
    final random = Random();
    switch (bankName) {
      case "Bank BCA":
        return List.generate(10, (_) => random.nextInt(10)).join();
      case "Bank BNI":
        return List.generate(10, (_) => random.nextInt(10)).join();
      case "Bank BRI":
        return List.generate(15, (_) => random.nextInt(10)).join();
      case "Bank BSI":
        return List.generate(10, (_) => random.nextInt(10)).join();
      case "Bank Mandiri":
        return List.generate(13, (_) => random.nextInt(10)).join();
      default:
        return List.generate(10, (_) => random.nextInt(10)).join();
    }
  }

  Future<void> _handleCheckout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      await _pesananService.tambahPesanan(
        widget.orders,
        widget.selectedPayment,
        widget.selectedSchedule,
      );

      for (var order in widget.orders) {
        final produkId = order['idProduk'];
        if (produkId != null) {
          await _keranjangService.removeFromCart(produkId);
        }
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
      );
    } catch (e) {
      debugPrint('Error checkout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout gagal. Coba lagi.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isLoading) return false;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Pembayaran',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: zelow,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16, bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffE6F9F1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Jumlah Transfer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito",
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatRupiah(widget.subtotal),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nunito",
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Nomor Rekening",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito",
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _accountNumber,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nunito",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _accountNumber),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Nomor rekening berhasil disalin"),
                              backgroundColor: zelow,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/images/icon_copy.svg",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "Salin Nomor",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Nunito",
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cara Membayar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Nunito",
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "1. Masuk ke akun bank Anda\n2. Pilih menu “Transfer”",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Nunito",
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "3. Pilih ",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nunito",
                          ),
                          children: [
                            TextSpan(
                              text: widget.selectedBankName,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Nunito",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "4. Masukkan nomor rekening ",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nunito",
                          ),
                          children: [
                            TextSpan(
                              text: _accountNumber,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Nunito",
                              ),
                            ),
                            const TextSpan(
                              text: " atau salin nomor rekening tersebut",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Nunito",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "5. Masukkan jumlah transfer\n6. Pastikan nominal sudah benar\n7. Konfirmasi dengan memasukkan pin Anda\n8. Pembayaran berhasil",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Nunito",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          padding: const EdgeInsets.only(bottom: 24, left: 18, right: 18),
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                        : const Text(
                          "Saya Sudah Membayar",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Nunito",
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
