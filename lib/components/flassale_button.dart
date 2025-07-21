import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class FlashSaleBoxButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final double width;

  const FlashSaleBoxButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.isSelected,
    this.width = 80,
  });

  @override
  Widget build(BuildContext context) {
    const Color selectedBg = Color(0xFFE6F9F1);
    final Color iconColor = isSelected ? zelow : Colors.grey;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 90,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: selectedBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon, color: iconColor, size: 32),
            SizedBox(
              width: double.infinity,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
