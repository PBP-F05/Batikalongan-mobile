import 'package:flutter/material.dart';
import '../widgets/gallery_card.dart';
import '../widgets/pagination_controls.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Galeri Batik',
          style: TextStyle(
            fontFamily: 'Fabled', // Menggunakan font custom
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Tombol tambah
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Buka form tambah
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD88E30), width: 2),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Tambah Batik',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color(0xFFD88E30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Galeri Batik (ListView)
            Expanded(
              child: ListView.builder(
                itemCount: 6, // Placeholder jumlah item
                itemBuilder: (context, index) {
                  return GalleryCard(
                    id: 'entry_$index',
                    namaBatik: 'Batik $index',
                    deskripsi: 'Deskripsi Batik $index',
                    asalUsul: 'Asal Usul Batik $index',
                    makna: 'Makna Batik $index',
                    fotoUrl: 'https://via.placeholder.com/150',
                    isAdmin: true, // Untuk menampilkan tombol Edit & Delete
                    onEdit: () {
                      print('Edit Batik $index');
                    },
                    onDelete: () {
                      print('Delete Batik $index');
                    },
                  );
                },
              ),
            ),

            // Pagination Controls
            PaginationControls(
              currentPage: 1,
              totalPages: 5,
              onPageChange: (page) {
                print('Pindah ke halaman $page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
