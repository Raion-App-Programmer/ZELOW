import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class RatingIcon extends StatefulWidget {

  final double rating;
  const RatingIcon({super.key, required this.rating});

  @override
  State<RatingIcon> createState() => _RatingIconState();
}

class _RatingIconState extends State<RatingIcon> {
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: widget.rating,
      itemSize: 19, 
      unratedColor: Color(0xFFFFF1D0),
      itemBuilder: (_, __) => const Icon(Icons.star, color: Color(0xFFFFD166)));
  }
}




