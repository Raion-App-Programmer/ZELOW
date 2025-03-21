import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';

class OrderItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double originalPrice;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const OrderItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Rp${price.toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: zelow),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Rp${originalPrice.toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onDecrease,
                  icon: Icon(Icons.remove_circle_outline, color: zelow),
                ),
                Text(quantity.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: onIncrease,
                  icon: Icon(Icons.add_circle_outline, color: zelow),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
