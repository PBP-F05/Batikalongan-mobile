import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        // Menghapus judul pada AppBar
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/back.svg', // Path ke file SVG
            height: 40, // Perbesar ukuran tombol back
            width: 40,
          ),
          onPressed: () {
            Navigator.pop(context); // Fungsi kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: Colors.transparent, // Transparan jika diperlukan
        elevation: 0, // Menghilangkan bayangan AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getImageProvider(image),
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
                style: const TextStyle(
                  color: Color(0xFFD88E30),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              child: Text(
                konten,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ],
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
