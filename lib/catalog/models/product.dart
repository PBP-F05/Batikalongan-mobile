class Product {
  final String id; // UUID
  final String name;
  final double price;
  final String storeId; // Reference to Store
  final String description;
  final String image; // URL or file path for the product's image

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.storeId,
    required this.description,
    required this.image,
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      storeId: json['storeId'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'storeId': storeId,
      'description': description,
      'image': image,
    };
  }
}
