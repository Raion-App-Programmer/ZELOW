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
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.stock,
    required this.sold,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double progress = stock > 0 ? sold / stock : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 180, // FIXED HEIGHT agar tidak overflow
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,

                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                        color: zelow,
                      ),
                    ),
                  );
                },

                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) {
                  return Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey[600],
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 6),
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
            Text(
              price,
              style: greenTextStyle.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: zelow,
              minHeight: 6,
            ),
            const SizedBox(height: 2),
            Text(
              "Stok: $sold/$stock",
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
