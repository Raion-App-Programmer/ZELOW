import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartBottomNavBar extends StatelessWidget {
  final int itemCount;
  final double totalPrice;
  final VoidCallback? onCheckoutPressed;

  const CartBottomNavBar({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    this.onCheckoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    const Color zelow = Color(0xff06C474);

    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {}, // opsional: bisa dibuat nonaktif jika perlu
                icon: Image.asset(
                  'assets/images/keranjangKu-icon.png',
                  width: 28,
                ),
              ),
              if (itemCount > 0)
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: zelow,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$itemCount',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp',
                  decimalDigits: 0,
                ).format(totalPrice),
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  color: zelow,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: itemCount > 0 ? onCheckoutPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: itemCount > 0 ? zelow : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: const Text(
              "Checkout",
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
