import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class FlashCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int stock; // Total stok
  final int sold; // Jumlah terjual
  final VoidCallback onTap;

  const FlashCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.stock,
    required this.sold,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = stock > 0 ? sold / stock : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120, 
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
          children: [
            // **Gambar Produk (Dikecilin)**
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                imageUrl,
                height: 80, 
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 6),

            // **Nama Produk**
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 10, 
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // **Harga Produk**
            Text(
              price,
              style: greenTextStyle.copyWith(
                fontSize: 10, 
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // **Progress Bar (Lebih kecil)**
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: zelow,
                minHeight: 6, 
              ),
            ),
            const SizedBox(height: 2),

            // **Stok Flash Sale**
            Text(
              "Stok: $sold/$stock",
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
