import 'package:flutter/material.dart';
import 'delete_confirmation_modal.dart';
class GalleryCard extends StatelessWidget {
  final String id;
  final String namaBatik;
  final String deskripsi;
  final String asalUsul;
  final String makna;
  final String fotoUrl;

  const GalleryCard({
    super.key,
    required this.id,
    required this.namaBatik,
    required this.deskripsi,
    required this.asalUsul,
    required this.makna,
    required this.fotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(fotoUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              namaBatik,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(deskripsi),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-entry');
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DeleteConfirmationModal(),
                  );
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
