import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 

class ArtikelBatikScreen extends StatelessWidget {
  const ArtikelBatikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image at the bottom of the stack
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/bg_artikel.svg', 
                fit: BoxFit.cover,
              ),
            ),
            // Main content in the foreground
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Artikel Batik',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Fabled',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildArtikelCard(
                          context,
                          title: 'Mengungkap Makna di Balik Motif Batik Khas Pekalongan',
                          description:
                              'Batik Pekalongan dikenal dengan motif-motif yang kaya akan makna dan simbolisme. Setiap motif memiliki cerita yang mendalam, mencerminkan nilai-nilai budaya dan sejarah masyarakat Pekalongan.',
                        ),
                        const SizedBox(height: 12),
                        _buildArtikelCard(
                          context,
                          title: 'Mengungkap Makna di Balik Motif Batik Khas Pekalongan',
                          description:
                              'Batik Pekalongan dikenal dengan motif-motif yang kaya akan makna dan simbolisme. Setiap motif memiliki cerita yang mendalam, mencerminkan nilai-nilai budaya dan sejarah masyarakat Pekalongan.',
                        ),
                      ],
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

  Widget _buildArtikelCard(BuildContext context,
      {required String title, required String description}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD88E30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Lihat Artikel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward, // Right arrow icon
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
