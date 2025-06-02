class Product {
  final String name;
  final String imagePath;
  final int quantity;
  final double price;
  final double originalPrice;
  bool isSelected;

  Product({
    required this.name,
    required this.imagePath,
    required this.quantity,
    required this.price,
    required this.originalPrice,
    this.isSelected = false,
  });
}
