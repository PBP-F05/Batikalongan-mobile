import 'product.dart';

class Store {
  final String id; // UUID
  final String name;
  final String address;
  final int productCount;
  final String image; // URL or file path for the store's image
  final List<Product> products; // List of related products

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.productCount,
    required this.image,
    this.products = const [], // Default empty list
  });

  // Factory method to create Store from JSON
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      productCount: json['productCount'] as int,
      image: json['image'] as String,
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  // Convert Store object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'productCount': productCount,
      'image': image,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
