class Product {
  final String image, name, description, color, category, size;
  final int id;
  final double price;

  Product({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.size,
    required this.id,
    required this.color,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
      size: json['size'],
      color: json['color'],
      category: json['category']['name'],
    );
  }
}
