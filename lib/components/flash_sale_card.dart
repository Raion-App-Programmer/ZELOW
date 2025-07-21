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
        width: 155,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 2,
              spreadRadius: 0.4,
              offset: Offset(0, 1),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,

                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 110,
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
                    height: 110,
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
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: greenTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 14,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.red.withOpacity(0.25),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                      minHeight: 16,
                    ),
                  ),
                  Center(
                    child: Text(
                      '$sold TERJUAL',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
