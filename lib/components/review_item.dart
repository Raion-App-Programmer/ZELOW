import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class ReviewItem extends StatelessWidget {
  final String reviewerName;
  final String reviewerImageUrl;
  final String komentar;
  final double rating;

  const ReviewItem({
    super.key,
    required this.reviewerName,
    required this.reviewerImageUrl,
    required this.komentar,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar dan rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Expanded(
                child: Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amberAccent,
                      size: 18,
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Komentar
          SizedBox(
            height: 36,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                komentar,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Nama reviewer
          Text(
            reviewerName,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
