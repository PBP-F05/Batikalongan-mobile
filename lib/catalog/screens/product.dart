import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalog App',
      home: CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Product> products = [];
  int currentPage = 1;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/catalog?page=$currentPage'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        products = (data['results'] as List)
            .map((item) => Product.fromJson(item))
            .toList();
        totalPages = data['total_pages'];
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ),
          Pagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
                fetchProducts();
              });
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageUrl),
          SizedBox(height: 8),
          Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Price: \$${product.price}'),
          SizedBox(height: 4),
          Text('Store: ${product.storeName} (${product.storeAddress})'),
        ],
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String storeName;
  final String storeAddress;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.storeName,
    required this.storeAddress,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['image_url'],
      storeName: json['store_name'],
      storeAddress: json['store_address'],
    );
  }
}

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 1)
            ElevatedButton(
              onPressed: () => onPageChanged(currentPage - 1),
              child: Text('Previous'),
            ),
          SizedBox(width: 16),
          Text('Page $currentPage of $totalPages'),
          SizedBox(width: 16),
          if (currentPage < totalPages)
            ElevatedButton(
              onPressed: () => onPageChanged(currentPage + 1),
              child: Text('Next'),
            ),
        ],
      ),
    );
  }
}

