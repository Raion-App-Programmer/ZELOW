import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/services/toko_service.dart';
import 'package:zelow/utils/format_mata_uang.dart';

class PesananBerlangsungCard extends StatefulWidget {
  final String idPesanan;
  final String tanggalPesanan;
  final String namaProduk;
  final int quantity;
  final double hargaSatuan;
  final String status;
  final String idToko;
  final String gambar;

  const PesananBerlangsungCard({
    super.key,
    required this.idPesanan,
    required this.tanggalPesanan,
    required this.namaProduk,
    required this.quantity,
    required this.hargaSatuan,
    required this.status,
    required this.idToko,
    required this.gambar,
  });

  @override
  State<PesananBerlangsungCard> createState() => _PesananBerlangsungCardState();
}

class _PesananBerlangsungCardState extends State<PesananBerlangsungCard> {
  final _tokoService = TokoServices();
  String _namaToko = '';

  @override
  void initState() {
    super.initState();
    _fetchTokoInfo();
  }

  void _fetchTokoInfo() async {
    final Toko toko = await _tokoService.getTokoById(widget.idToko);
    setState(() {
      _namaToko = toko.nama;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header row with order number and date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Order number at top left
                Text(
                  '#${widget.idPesanan}',
                  style: greenTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Order date at top right
                Text(
                  widget.tanggalPesanan,
                  style: greyTextStyle.copyWith(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Card content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food image (smaller)
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  widget.gambar, // Placeholder image
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 6),

              // Food details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant name with store icon
                      Row(
                        children: [
                          Icon(
                            Icons.storefront_rounded,
                            size: 16,
                            color: zelow,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _namaToko,
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

                      // Food item name
                      Padding(
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          widget.namaProduk,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 4),
                      // Quantity
                      Text(
                        '${widget.quantity}x',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Prices
                      Row(
                        children: [
                          Text(
                            FormatMataUang.formatRupiah(widget.hargaSatuan, 0),
                            style: greenTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4),

                          // Ini untuk diskon belum berfungsi
                          // Text(
                          //   'Rp12.500',
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //     color: Colors.grey,
                          //     decoration: TextDecoration.lineThrough,
                          //     decorationThickness: 1.5,
                          //   ),
                          // ),
                        ],
                      ),

                      // Status - moved to a separate row below prices
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          child: Text(
                            widget.status,
                            style: greyTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
