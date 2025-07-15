// import 'package:flutter/material.dart';
// import 'package:zelow/components/constant.dart';

// class ProductTokoCard extends StatelessWidget {
//   final String imageUrl;
//   final String restaurantName;
//   final String description;
//   final double harga;
//   final VoidCallback onTap;

//   const ProductTokoCard({
//     Key? key,
//     required this.imageUrl,
//     required this.restaurantName,
//     required this.description,
//     required this.harga,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.9, // Lebar card panjang
//         margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               spreadRadius: 2,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Gambar Produk (Kotak di kiri)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 imageUrl,
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 10),

//             //Isi Utama
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Nama Resto
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         restaurantName,
//                         style: blackTextStyle.copyWith(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       // Deskripsi Singkat
//                       Text(
//                         description,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 18),

//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           "RP${harga.toStringAsFixed(3)}",
//                           style: TextStyle(
//                               color: zelow,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                             decoration: BoxDecoration(
//                               color: zelow,
//                               shape: BoxShape.circle, // Bentuk lingkaran
//                             ),
//                             child: Icon(
//                                 Icons.add,
//                               color: Colors.white,
//                             )
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 6),

//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zelow/components/constant.dart';

class ProductTokoCard extends StatelessWidget {
  final String imageUrl;
  final String restaurantName;
  final String description;
  final double harga;
  final VoidCallback onTap;

  const ProductTokoCard({
    super.key,
    required this.imageUrl,
    required this.restaurantName,
    required this.description,
    required this.harga,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedHarga = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(harga);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar Produk (Kotak di kiri)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 90,
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
                    height: 90,
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
            const SizedBox(width: 10),

            //Isi Utama
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Resto
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantName,
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Deskripsi Singkat
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Text(
                          formattedHarga,
                          style: TextStyle(
                            color: zelow,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: zelow,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
