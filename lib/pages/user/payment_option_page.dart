import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/pages/user/payment_page.dart';

class PaymentOptionPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;
  final double subtotal;
  final String selectedPayment;
  final String selectedSchedule;

  const PaymentOptionPage({
    Key? key,
    required this.orders,
    required this.subtotal,
    required this.selectedPayment,
    required this.selectedSchedule,
  }) : super(key: key);

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  int? selectedIndex;
  String? _selectedBankName;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "image": Image(image: AssetImage("assets/images/bca.png")),
      "label": "Bank BCA",
    },
    {
      "image": Image(image: AssetImage("assets/images/bni.png")),
      "label": "Bank BNI",
    },
    {
      "image": Image(image: AssetImage("assets/images/bri.png")),
      "label": "Bank BRI",
    },
    {
      "image": Image(image: AssetImage("assets/images/bsi.png")),
      "label": "Bank BSI",
    },
    {
      "image": Image(image: AssetImage("assets/images/mandiri.png")),
      "label": "Bank Mandiri",
    },
    // {
    //   "image": Image(image: AssetImage("assets/images/visa.png")),
    //   "label": "VISA",
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pilih Metode Transfer',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < paymentMethods.length; index++)
                _buildPaymentOption(index),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(bottom: 24, left: 18, right: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedBankName != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PaymentPage(
                            orders: widget.orders,
                            subtotal: widget.subtotal,
                            selectedPayment: widget.selectedPayment,
                            selectedSchedule: widget.selectedSchedule,
                            selectedBankName: _selectedBankName!,
                          ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Silakan pilih bank terlebih dahulu"),
                      backgroundColor: zelow,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: zelow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                "Pilih",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          _selectedBankName = paymentMethods[index]['label'];
        });
      },
      child: Container(
        height: 90,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? zelow : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 48,
              child: paymentMethods[index]['image'],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                paymentMethods[index]['label'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? zelow : white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
