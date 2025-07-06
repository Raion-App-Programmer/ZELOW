import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/components/whatsApp.dart';

class chatList extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String nomor;

  const chatList({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.nomor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bukaWhatsapp(
          nomor: nomor,
          pesan: 'Halo, saya ingin bertanya tentang produk di toko Anda.',
        );
      },
      child: Column(
        children: [
          const SizedBox(height: 2),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: imageUrl.startsWith('assets/')
                      ? Image.asset(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported);
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      name,
                      style: blackTextStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}