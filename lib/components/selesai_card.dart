import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class PesananSelesaiCard extends StatelessWidget {
  final String orderNumber;
  final String orderDate;

  const PesananSelesaiCard({
    super.key,
    required this.orderNumber,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                // Order number at top left
                Text(
                  '#$orderNumber',
                  style: greenTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Order date at top right
                Text(
                  orderDate,
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
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
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                ),
                child: Image.network(
                  'https://picsum.photos/200/200', // Placeholder image
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

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
                            size: 14,
                            color: zelow,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child:  Text(
                              'Masakan Padang Roda Dua, Bendungan Sutami',
                              style: blackTextStyle.copyWith(
                               
                                fontSize: 14,
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
                          'Nasi Padang Rendang + Telor',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Quantity
                      Text(
                        '1x',
                        style: TextStyle(
                          color: black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      // Prices
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            'Rp10.000',
                            style: greenTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Rp12.500',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                      
                      // Replaced "Menunggu Konfirmasi" with buttons
                      SizedBox(height: 8),
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    // Button "Nilai"
    OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: zelow),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Perbesar padding
        minimumSize: Size(100, 40), // Perbesar ukuran minimum
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Tambah border radius
        ),
      ),
      child: Text(
        'Nilai',
        style: TextStyle(
          color: zelow,
          fontSize: 14, // Perbesar ukuran teks
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    SizedBox(width: 12), // Tambah jarak antar tombol
    // Button "Beli Lagi"
    ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: zelow,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Perbesar padding
        minimumSize: Size(100, 40), // Perbesar ukuran minimum
        elevation: 2, // Tambahkan shadow biar lebih tegas
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Tambah border radius
        ),
      ),
      child: Text(
        'Beli Lagi',
        style: TextStyle(
          fontSize: 14, // Perbesar ukuran teks
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