import 'package:flutter/material.dart';
import 'dart:convert';


class ArtikelDetailScreen extends StatelessWidget {
  final String judul;
  final String konten;
  final String image;

  const ArtikelDetailScreen({
    super.key,
    required this.judul,
    required this.konten,
    required this.image,
  });
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _getImageProvider(
                          image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: Text(
                  judul,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD88E30),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              // Konten Artikel
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      konten,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0.12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String image) {
    if (image.isEmpty) {
      return const AssetImage('images/placeholder.jpg');
    } else {
      try {
        final bytes = base64Decode(image);
        return MemoryImage(bytes);
      } catch (e) {
        return const AssetImage('images/placeholder.jpg');
      }
    }
  }
}
