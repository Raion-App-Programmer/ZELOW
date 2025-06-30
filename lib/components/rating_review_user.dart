import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingReviewUser extends StatefulWidget {

  final double rating;
  const RatingReviewUser ({super.key, required this.rating});

  @override
  State<RatingReviewUser > createState() => _RatingReviewUser ();
}

class _RatingReviewUser  extends State<RatingReviewUser > {
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: widget.rating,
      itemSize: 15, 
      unratedColor: Color(0xFFFFF1D0),
      itemBuilder: (_, __) => const Icon(Icons.star, color: Color(0xFFFFD166)));
  }
}


