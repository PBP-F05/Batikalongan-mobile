import 'package:batikalongan_mobile/article/screens/artikel_detail_screen.dart';
import 'package:batikalongan_mobile/article/screens/artikel_edit_screen.dart'; // Impor screen ArtikelEditScreen
import 'package:flutter/material.dart';
import 'dart:io'; // Untuk File dan Image.file
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

class ArtikelCardWidget extends StatelessWidget {
  final String judul;
  final String pendahuluan;
  final String imagePath;

  const ArtikelCardWidget({
    Key? key,
    required this.judul,
    required this.pendahuluan,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0), // Padding kiri dan kanan
      child: Container(
        width: double.infinity, // Agar card tetap fleksibel
        child: Column(
          mainAxisSize: MainAxisSize.min, // Agar tinggi card mengikuti konten
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar Header
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 111,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: imagePath.isNotEmpty
                          ? kIsWeb
                              ? NetworkImage(imagePath) // Gambar dari URL (Web)
                              : FileImage(File(imagePath))
                                  as ImageProvider // Gambar lokal di perangkat
                          : const AssetImage(
                              "images/placeholder.jpg"), // Gambar placeholder
                      fit: BoxFit
                          .cover, // Gunakan BoxFit.cover untuk menjaga rasio aspek gambar
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Tombol Edit dan Delete
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/edit.svg', // Path ke file edit.svg
                        ),
                        onPressed: () {
                          // Navigasi ke ArtikelEditScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArtikelEditScreen(
                                initialJudul: judul,
                                initialPendahuluan: pendahuluan,
                                initialKonten:
                                    pendahuluan, // Ganti jika ada konten penuh
                                initialImagePath: imagePath,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/delete.svg', // Path ke file delete.svg
                        ),
                        onPressed: () {
                          // Aksi untuk delete artikel
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Konten Utama (Judul, Pendahuluan, dan Tombol)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(color: Color(0xFFD9D9D9), width: 1),
              ),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Menyesuaikan tinggi dengan konten
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul, // Menampilkan judul artikel
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pendahuluan, // Menampilkan pendahuluan artikel
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.5, // Menambahkan jarak antar baris teks
                    ),
                    maxLines: 3, // Batasi jumlah baris teks
                    overflow: TextOverflow
                        .ellipsis, // Teks yang terlalu panjang akan diganti dengan "..."
                  ),
                  const SizedBox(height: 16),
                  // Tombol Lihat Artikel
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke ArtikelDetailScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtikelDetailScreen(
                            judul: judul, // Mengirimkan judul artikel
                            konten: pendahuluan, // Mengirimkan konten artikel
                            imagePath: imagePath,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD88E30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .max, // Gunakan max untuk memanfaatkan lebar penuh
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Membuat space antara teks dan ikon
                        children: [
                          Text(
                            'Lihat Artikel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 24), // Ikon di kanan
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
