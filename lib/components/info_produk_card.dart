import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class InfoProdukCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final int jumlahTerjual;
  final int likeCount;
  final double price;
  final List<ReviewItem> reviews;
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
    required this.price,
    required this.itemCount,
    this.reviews = const [],
    this.onSavePressed,
    this.onSharePressed,
    this.onAddPressed,
    this.onRemovePressed,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: 8),
                
                // Rating and reviews count
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$jumlahTerjual terjual | Disukai oleh $likeCount',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 34, 29, 29),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 12),
                
                // Price and add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp${price.toInt()}',
                      style: TextStyle(
                        color: zelow,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        if (itemCount > 0)
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle,
                              border: Border.all(color: zelow, width: 1),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.remove, color: zelow),
                              onPressed: onRemovePressed,
                              constraints: BoxConstraints(
                                minHeight: 36,
                                minWidth: 36,
                              ),
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                            ),
                          ),

                        SizedBox(width: 10),

                        if (itemCount > 0)
                          Text(
                            itemCount.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                        SizedBox(width: 10),

                        Container(
                          decoration: BoxDecoration(
                            color: zelow,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: onAddPressed,
                            constraints: BoxConstraints(
                              minHeight: 36,
                              minWidth: 36,
                            ),
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: 12),
                
                // Save and share buttons
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: onSavePressed,
                      icon: Icon(Icons.favorite_border, size: 18,),
                      label: Text('Simpan'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: zelow,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: onSharePressed,
                      icon: Icon(Icons.share, size: 18),
                      label: Text('Bagikan'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: zelow,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (reviews.isNotEmpty) ...[
                  SizedBox(height: 16),
                  
                  // Reviews section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kata Mereka',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Review items
                  Row(
                    children: reviews
                        .take(2)
                        .map((review) => Expanded(child: review))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String reviewerName;
  final String reviewerImageUrl;
  final double rating;

  const ReviewItem({
    Key? key,
    required this.reviewerName,
    required this.reviewerImageUrl,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(reviewerImageUrl),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 14,
                      ),
                    ),
                  ),
                  Text(
                    reviewerName,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Example usage
// class FoodItemExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Food Item"),
//         leading: BackButton(),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: InfoProdukCard(
//             title: "Nasi Padang Ayam Kari",
//             imageUrl: "https://example.com/nasi-padang.jpg",
//             rating: 4.9,
//             jumlahTerjual: 689,
//             likeCount: 342,
//             price: 20000,
//             reviews: [
//               ReviewItem(
//                 reviewerName: "Nana Mirdad",
//                 reviewerImageUrl: "https://example.com/avatar1.jpg",
//                 rating: 5,
//               ),
//               ReviewItem(
//                 reviewerName: "Nana Mirdad",
//                 reviewerImageUrl: "https://example.com/avatar1.jpg",
//                 rating: 5,
//               ),
//             ],
//             onSavePressed: () {},
//             onSharePressed: () {},
//             onAddPressed: () {},
//           ),
//         ),
//       ),
//     );
//   }
// }