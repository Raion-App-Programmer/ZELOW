import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/utils/format_mata_uang.dart';

class ProductTokoCard extends StatelessWidget {
  final String imageUrl;
  final String restaurantName;
  final String description;
  final double harga;
  final VoidCallback onTap;
  final bool isFlashSale;

  const ProductTokoCard({
    super.key,
    required this.imageUrl,
    required this.restaurantName,
    required this.description,
    required this.harga,
    required this.onTap,
    this.isFlashSale = false,
  });

  @override
  Widget build(BuildContext context) {

    final formattedHarga = FormatMataUang.formatRupiah(harga, 0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 2,
              spreadRadius: 0.4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 95,
                width: 95,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 95,
                    width: 95,
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
                errorBuilder: (context, exception, stackTrace) {
                  return Container(
                    height: 95,
                    width: 95,
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
            const SizedBox(width: 16),

            // Konten Teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      if (isFlashSale) ...[
                        Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp',
                            decimalDigits: 0,
                          ).format(harga * 0.8),
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 21,
                            color: zelow,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          formattedHarga,
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ] else ...[
                        Text(
                          formattedHarga,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 21,
                            color: zelow,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: zelow,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
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
