import 'package:flutter/material.dart';
import '../widgets/gallery_card.dart';
import '../widgets/pagination_controls.dart';
import '../widgets/delete_confirmation_modal.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri Batik'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6, // Placeholder for API data
              itemBuilder: (context, index) {
                return GalleryCard(
                  id: 'entry_$index',
                  namaBatik: 'Batik $index',
                  deskripsi: 'Deskripsi Batik $index',
                  asalUsul: 'Asal Usul $index',
                  makna: 'Makna Batik $index',
                  fotoUrl: 'https://via.placeholder.com/150', // Placeholder
                );
              },
            ),
          ),
          PaginationControls(
            currentPage: 1,
            totalPages: 5,
            onPageChange: (page) {
              // Handle pagination logic
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-entry');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
