import 'package:cloud_firestore/cloud_firestore.dart';

class Pesanan {
  final String id;
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final double serviceFee;
  final String status;
  final Timestamp orderDate;
  final String userId;
  final int orderNumber;

  Pesanan({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.serviceFee,
    required this.status,
    required this.orderDate,
    required this.userId,
    required this.orderNumber,
  });

  factory Pesanan.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Pesanan(
      id: doc.id,
      items: List<Map<String, dynamic>>.from(data['items']),
      totalPrice: data['totalPrice'],
      serviceFee: data['serviceFee'],
      status: data['status'],
      orderDate: data['orderDate'],
      userId: data['userId'],
      orderNumber: data['orderNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'items': items,
      'totalPrice': totalPrice,
      'serviceFee': serviceFee,
      'status': status,
      'orderDate': orderDate,
      'userId': userId,
      'orderNumber': orderNumber,
    };
  }
}