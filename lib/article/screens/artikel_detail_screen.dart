import 'package:flutter/material.dart';
import 'dart:io'; // Untuk File dan Image.file
import 'package:flutter/foundation.dart'; // Untuk kIsWeb

class ArtikelDetailScreen extends StatelessWidget {
  final String judul;
  final String konten;
  final String imagePath;

  const ArtikelDetailScreen({
    Key? key,
    required this.judul,
    required this.konten,
    required this.imagePath, // Menerima path gambar
  }) : super(key: key);
  

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
              // Menampilkan gambar di atas judul artikel
              Container(
                width: double.infinity,
                height: 200, // Tentukan tinggi gambar
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imagePath.isNotEmpty
                        ? kIsWeb
                            ? NetworkImage(
                                imagePath) // Untuk gambar dari URL (Web)
                            : File(imagePath).existsSync()
                                ? FileImage(File(imagePath)) // Gambar lokal
                                : const AssetImage("images/placeholder.jpg")
                                    as ImageProvider // Jika tidak ditemukan gambar
                        : const AssetImage(
                            "images/placeholder.jpg"), // Placeholder jika imagePath kosong
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 28),
              // Judul Artikel
              SizedBox(
                width: double.infinity,
                child: Text(
                  judul, // Judul yang dikirim dari parameter
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
                      konten, // Konten artikel yang dikirim
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
}
