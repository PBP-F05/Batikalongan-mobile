import 'package:flutter/material.dart';

class DeleteConfirmationModal extends StatelessWidget {
  const DeleteConfirmationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hapus Entri Galeri'),
      content: const Text('Apakah Anda yakin ingin menghapus entri ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle delete logic
            Navigator.pop(context);
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  }
}
