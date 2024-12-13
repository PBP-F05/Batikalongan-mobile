import 'package:batikalongan_mobile/article/widgets/edit_form.dart';
import 'package:flutter/material.dart';

class ArtikelEditScreen extends StatefulWidget {
  final String initialJudul;
  final String initialPendahuluan;
  final String initialKonten;
  final String initialImagePath;

  const ArtikelEditScreen({
    Key? key,
    required this.initialJudul,
    required this.initialPendahuluan,
    required this.initialKonten,
    required this.initialImagePath,
  }) : super(key: key);

  @override
  _ArtikelEditScreenState createState() => _ArtikelEditScreenState();
}

class _ArtikelEditScreenState extends State<ArtikelEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Artikel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EditForm(
          initialJudul: widget.initialJudul,
          initialPendahuluan: widget.initialPendahuluan,
          initialKonten: widget.initialKonten,
          initialImagePath: widget.initialImagePath,
          onSubmit: (editedData) {
            // Logika untuk menangani data yang sudah diedit
            // Misalnya, bisa mengirim data ke API atau mengupdate state di sini
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Artikel berhasil diupdate!")),
            );
            Navigator.pop(
                context); // Kembali ke layar sebelumnya setelah menyimpan
          },
        ),
      ),
    );
  }
}
