import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/produk_model.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/pages/user/chekout_page.dart';
import 'package:zelow/pages/user/toko_page.dart';
import 'package:zelow/utils/format_mata_uang.dart';

class SurpriseCard extends StatefulWidget {
  final Produk productData;
  final Toko tokoData;
  final VoidCallback onTap;

  const SurpriseCard({
    Key? key,
    required this.productData,
    required this.tokoData,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SurpriseCard> createState() => _SurpriseCardState();
}

class _SurpriseCardState extends State<SurpriseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                widget.productData.gambar,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                        color: zelow,
                        strokeWidth: 2.5,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey[600],
                      size: 32,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Toko
                    Row(
                      children: [
                        Icon(Icons.storefront_rounded, size: 16, color: zelow),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.tokoData.nama,
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Nama Produk
                    Text(
                      widget.productData.nama,
                      style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Info jumlah
                    const Text(
                      "Maks. pembelian Surprise Box 1",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 4),

                    // Harga
                    Text(
                      FormatMataUang.formatRupiah(widget.productData.harga, 0),
                      style: greenTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tombol
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        TokoPageUser(tokoData: widget.tokoData),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: zelow, width: 1),
                            ),
                            child: Text(
                              'Lihat Toko',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: zelow,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CheckoutPage(
                                      orders: [
                                        {
                                          'idToko': widget.productData.idToko,
                                          'idProduk':
                                              widget.productData.idProduk,
                                          'title': widget.productData.nama,
                                          'imageUrl': widget.productData.gambar,
                                          'price': widget.productData.harga,
                                          'quantity': 1,
                                          'originalPrice':
                                              widget.productData.harga,
                                          'nama': widget.tokoData.nama,
                                          'alamat': widget.tokoData.alamat,
                                          'stok': widget.productData.stok,
                                          'terjual': widget.productData.terjual,
                                          'isFlashSale':
                                              widget.productData.isFlashSale,
                                          'deskripsi':
                                              widget.productData.deskripsi,
                                        },
                                      ],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: zelow,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Checkout',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
