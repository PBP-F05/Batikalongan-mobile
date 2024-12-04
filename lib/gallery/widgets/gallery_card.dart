import 'package:flutter/material.dart';

class GalleryCard extends StatelessWidget {
  final String id;
  final String namaBatik;
  final String deskripsi;
  final String asalUsul;
  final String makna;
  final String fotoUrl;
  final bool isAdmin;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GalleryCard({
    super.key,
    required this.id,
    required this.namaBatik,
    required this.deskripsi,
    required this.asalUsul,
    required this.makna,
    required this.fotoUrl,
    this.isAdmin = false,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              fotoUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),

          // Detail Batik
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Batik
                Text(
                  namaBatik,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Deskripsi
                Text(
                  deskripsi,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Makna
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Makna: $makna',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Asal Usul
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Asal Usul: $asalUsul',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tombol Admin (Edit & Delete)
          if (isAdmin)
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.yellow),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
