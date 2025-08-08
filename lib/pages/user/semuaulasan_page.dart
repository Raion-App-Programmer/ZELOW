import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zelow/components/constant.dart';

class SemuaUlasanPage extends StatelessWidget {
  final String idProduk;
  final String productName;

  const SemuaUlasanPage({
    Key? key,
    required this.idProduk,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Kata Mereka',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: zelow,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('produk')
            .doc(idProduk)
            .collection('ulasan')
            .orderBy('tanggal', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Terjadi kesalahan saat memuat ulasan',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: zelow,
              ),
            );
          }

          final ulasanDocs = snapshot.data!.docs;

          if (ulasanDocs.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada ulasan untuk produk ini',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return Column(
            children: [
              // Rating Overview Section
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: _buildRatingOverview(ulasanDocs),
              ),

              // Divider
              Container(
                height: 8,
                color: Colors.grey[100],
              ),

              // Reviews List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: ulasanDocs.length,
                  itemBuilder: (context, index) {
                    final data = ulasanDocs[index].data() as Map<String, dynamic>;
                    return _buildReviewItem(
                      reviewerName: data['fullname'] ?? 'Anonim',
                      komentar: data['komentar'] ?? '',
                      rating: (data['rating'] is num)
                          ? (data['rating'] as num).toDouble()
                          : 5.0,
                      tanggal: data['tanggal'],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRatingOverview(List<QueryDocumentSnapshot> ulasanDocs) {
    // Calculate rating statistics
    Map<int, int> ratingCount = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    double totalRating = 0;
    int totalReviews = ulasanDocs.length;

    for (var doc in ulasanDocs) {
      final data = doc.data() as Map<String, dynamic>;
      double rating = (data['rating'] is num) ? (data['rating'] as num).toDouble() : 5.0;
      int roundedRating = rating.round();
      ratingCount[roundedRating] = (ratingCount[roundedRating] ?? 0) + 1;
      totalRating += rating;
    }

    double averageRating = totalReviews > 0 ? totalRating / totalReviews : 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Average rating
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < averageRating ? Colors.amber : Colors.grey[300],
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(
                '($totalReviews Penilaian)',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 20),

        // Right side - Rating bars
        Expanded(
          flex: 3,
          child: Column(
            children: List.generate(5, (index) {
              int starNumber = 5 - index;
              int count = ratingCount[starNumber] ?? 0;
              double percentage = totalReviews > 0 ? count / totalReviews : 0;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Text(
                      '$starNumber',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: percentage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: zelow,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String reviewerName,
    required String komentar,
    required double rating,
    required dynamic tanggal,
  }) {
    // Calculate time ago
    String timeAgo = '2 hari lalu'; // Default fallback
    if (tanggal != null) {
      DateTime reviewDate;
      if (tanggal is Timestamp) {
        reviewDate = tanggal.toDate();
      } else if (tanggal is DateTime) {
        reviewDate = tanggal;
      } else {
        reviewDate = DateTime.now();
      }

      final difference = DateTime.now().difference(reviewDate);
      if (difference.inDays > 0) {
        timeAgo = '${difference.inDays} hari lalu';
      } else if (difference.inHours > 0) {
        timeAgo = '${difference.inHours} jam lalu';
      } else {
        timeAgo = 'Baru saja';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name, stars and time
          Row(
            children: [
              // Profile image
              CircleAvatar(
                radius: 16,
                backgroundColor: zelow.withOpacity(0.1),
                child: Text(
                  reviewerName.isNotEmpty ? reviewerName[0].toUpperCase() : 'A',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    color: zelow,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Name and stars
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < rating ? Colors.amber : Colors.grey[300],
                              size: 14,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Review comment
          Text(
            komentar,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}