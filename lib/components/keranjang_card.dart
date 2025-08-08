import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/keranjang_model.dart';
import 'package:intl/intl.dart';

class CardItemSample extends StatelessWidget {
  // final Product product;
  final KeranjangModel item;
  final VoidCallback onTap;
  final bool isSelected;

  const CardItemSample({
    super.key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? zelow : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),

        padding: const EdgeInsets.all(12), // padding dalam card
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/lets-icons_shop.png', width: 17.0),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.alamat,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.produk.gambar,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 17),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.produk.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "${item.quantity}x",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFB8B8B8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: 'Rp',
                              decimalDigits: 0,
                            ).format(item.produk.harga),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF06C474),
                            ),
                          ),
                          const SizedBox(width: 4),

                          // Jika ada harga diskon, tampilkan harga lama yang dicoret

                          // Text(
                          //   "Rp${item.produk.harga.toInt()}",
                          //   style: const TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w500,
                          //     decoration: TextDecoration.lineThrough,
                          //     color: Color(0xFFB8B8B8),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
