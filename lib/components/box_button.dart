import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class BoxButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String text;

  const BoxButton({super.key, required this.icon, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [zelow, Color(0xFF4F9880)], // Warna gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(2, 4),
            ),
          ],
        ),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 5), // Jarak icon & teks
            Text(
              text, // Pakai teks dari homepage
              style: whiteTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.bold,
              )
              
            ),
          ],
        ),
      ),
    );
  }
}
