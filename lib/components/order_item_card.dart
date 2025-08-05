import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:intl/intl.dart';

class OrderItemCard extends StatelessWidget {
  final String gambar;
  final String nama;
  final double harga;
  final double hargaAsli;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const OrderItemCard({
    super.key,
    required this.gambar,
    required this.nama,
    required this.harga,
    required this.hargaAsli,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              gambar,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      currencyFormat.format(harga),
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xFF06C474), // greenHex
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (harga != hargaAsli)
                      Text(
                        currencyFormat.format(hargaAsli),
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildCircleIcon(
                      icon: Icons.remove,
                      onPressed: onDecrease,
                      bgColor: Colors.white,
                      iconColor: const Color(0xFF06C474),
                      borderColor: const Color(0xFF06C474),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildCircleIcon(
                      icon: Icons.add,
                      onPressed: onIncrease,
                      bgColor: const Color(0xFF06C474),
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon({
    required IconData icon,
    required VoidCallback? onPressed,
    required Color bgColor,
    required Color iconColor,
    Color? borderColor,
  }) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border:
            borderColor != null
                ? Border.all(color: borderColor, width: 1.5)
                : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: iconColor),
        padding: EdgeInsets.zero,
        splashRadius: 20,
      ),
    );
  }
}
