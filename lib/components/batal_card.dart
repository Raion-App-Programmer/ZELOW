import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/toko_model.dart';
import 'package:zelow/services/toko_service.dart';
import 'package:zelow/utils/format_mata_uang.dart';

class PesananBatalCard extends StatefulWidget {
  final String idPesanan;
  final String tanggalPesanan;
  final String gambar;
  final String namaProduk;
  final int quantity;
  final double hargaSatuan;
  final String idToko;

  const PesananBatalCard({
    super.key,
    required this.idPesanan,
    required this.tanggalPesanan,
    required this.gambar,
    required this.namaProduk,
    required this.quantity,
    required this.hargaSatuan,
    required this.idToko,
  });

  @override
  State<PesananBatalCard> createState() => _PesananBatalCardState();
}

class _PesananBatalCardState extends State<PesananBatalCard> {
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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
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
                Text(
                  '#${widget.idPesanan}',
                  style: greenTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.tanggalPesanan,
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and "Pesanan Dibatalkan" text
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Image.network(
                      widget.gambar, // Placeholder image
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Pesanan Dibatalkan',
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Food details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 8,
                    left: 3,
                    bottom: 8,
                    top: 8
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant name
                      Row(
                        children: [
                          Icon(
                            Icons.storefront_rounded,
                            size: 14,
                            color: zelow,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _namaToko,
                              style: blackTextStyle.copyWith(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          widget.namaProduk,
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Text(
                        '${widget.quantity}x',
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            FormatMataUang.formatRupiah(widget.hargaSatuan, 0),
                            style: greenTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),

                          // Text(
                          //   'Rp12.500',
                          //   style: const TextStyle(
                          //     fontSize: 10,
                          //     color: Colors.grey,
                          //     decoration: TextDecoration.lineThrough,
                          //     decorationThickness: 1.5,
                          //   ),
                          // ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: zelow,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              minimumSize: const Size(100, 40),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Beli Lagi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}
