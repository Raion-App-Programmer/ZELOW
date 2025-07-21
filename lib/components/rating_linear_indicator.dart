import 'package:flutter/material.dart';

class RatingLinear extends StatefulWidget {
  final double rate;
  final String text;
  const RatingLinear({super.key, required this.text, required this.rate});
  

  @override
  State<RatingLinear> createState() => _RatingLinearState();
}

class _RatingLinearState extends State<RatingLinear> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(widget.text),
        SizedBox(width: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: LinearProgressIndicator(
            value: widget.rate,
            minHeight: 6,
            backgroundColor: Color(0xFFE6E6E6),
            borderRadius: BorderRadius.circular(12),
            valueColor: AlwaysStoppedAnimation(Color(0xFF06C474)),
          ),
        ),
      ],
    );
  }
}
