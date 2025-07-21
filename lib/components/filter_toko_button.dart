import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class FilterTokoButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final double width;

  const FilterTokoButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
    this.width = 88, // Default width
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: 28,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? zelow.withOpacity(0.1) : Colors.transparent, // Background transparan/putih
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? zelow : Color(0xFFB8B8B8), // Warna outline
            width: 1.0, // Ketebalan outline
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? zelow : Color(0xFF676767), // Warna text
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