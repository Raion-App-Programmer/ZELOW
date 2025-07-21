import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class InfoProdukCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final int jumlahTerjual;
  final int likeCount;
  final double price;
  final int stok;
  final int terjual;
  final double originalPrice;
  final bool isFlashSale;
  final VoidCallback? onSavePressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onAddPressed;
  final VoidCallback? onRemovePressed;
  final int itemCount;

  const InfoProdukCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.jumlahTerjual,
    required this.likeCount,
    required this.itemCount,
    required this.price,
    required this.stok,
    required this.terjual,
    this.originalPrice = 0,
    this.isFlashSale = false,
    this.onSavePressed,
    this.onSharePressed,
    this.onAddPressed,
    this.onRemovePressed,
  });

  String formatRupiah(num value) {
    return 'Rp${value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gambar Produk
        Image.network(
          imageUrl,
          height: 280,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),

        // Konten
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 24),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Text(
                '$jumlahTerjual terjual | Disukai oleh $likeCount',
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        // Harga diskon
                        formatRupiah(price),
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06C474),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (isFlashSale)
                        Text(
                          // Harga coret
                          formatRupiah(originalPrice),
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),

                  Row(
                    children: [
                      if (itemCount > 0)
                        _buildCircleIcon(
                          icon: Icons.remove,
                          onPressed: onRemovePressed,
                          bgColor: Colors.white,
                          iconColor: const Color(0xFF06C474),
                          borderColor: const Color(0xFF06C474),
                        ),
                      if (itemCount > 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      _buildCircleIcon(
                        icon: Icons.add,
                        onPressed: onAddPressed,
                        bgColor: const Color(0xFF06C474),
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  _buildRoundedOutlinedButton(
                    icon: Icons.favorite_border,
                    label: 'Simpan',
                    onPressed: onSavePressed,
                  ),
                  const SizedBox(width: 8),
                  _buildRoundedOutlinedButton(
                    icon: Icons.share,
                    label: 'Bagikan',
                    onPressed: onSharePressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border:
            borderColor != null
                ? Border.all(color: borderColor, width: 2)
                : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: iconColor),
        padding: EdgeInsets.zero,
        splashRadius: 18,
      ),
    );
  }

  Widget _buildRoundedOutlinedButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: Colors.grey.shade700),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade700,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(0, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
