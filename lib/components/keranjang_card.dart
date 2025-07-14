import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/models/keranjang_model.dart';

class CardItemSample extends StatelessWidget {
  // final Product product;
  final KeranjangItem item;
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
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? zelow : Colors.transparent,
            width: 2
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
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
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    "Masakan Padang Roda Dua, Bendungan Suta...", // Alamat toko, nanti saja
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                            "Rp${item.produk.harga.toInt()}",
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

// class _CardItemSampleState extends State<CardItemSample> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: 12, right: 20, left: 20),
//           width: MediaQuery.of(context).size.width * 0.9,
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Image.asset('assets/images/lets-icons_shop.png', width: 17.0),
//                   SizedBox(width: 4),
//                   Expanded(
//                     child: Text(
//                       "Masakan Padang Roda Dua, Bendungan Suta...",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 12),
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(
//                       'assets/images/naspad.jpg',
//                       width: 80,
//                       height: 80,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(width: 17),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Nasi Padang, Ayam Kare",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Padding(padding: EdgeInsets.only(top: 20)),
//                         Text(
//                           "1x",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFFB8B8B8),
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         Padding(padding: EdgeInsets.only(top: 4)),

//                         Row(
//                           children: [
//                             Text(
//                               "Rp13.000",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF06C474),
//                               ),
//                             ),
//                             SizedBox(width: 4),
//                             Text(
//                               "Rp23.000",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFFB8B8B8),
//                                 decoration: TextDecoration.lineThrough,
//                                 decorationColor: Color(0xFFB8B8B8), // Coret
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(width: 10),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
