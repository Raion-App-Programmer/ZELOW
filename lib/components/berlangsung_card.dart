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
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${widget.idPesanan}',
                  style: greenTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  widget.gambar,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
                      Text(
                        '${widget.quantity}x',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            FormatMataUang.formatRupiah(widget.hargaSatuan, 0),
                            style: greenTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),
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
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w600,
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
