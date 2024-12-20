import 'package:batikalongan_mobile/article/widgets/edit_form.dart';
import 'package:flutter/material.dart';
class ArtikelEditScreen extends StatefulWidget {
  final int id;
  final String initialJudul;
  final String initialPendahuluan;
  final String initialKonten;
  final String initialImage;

  const ArtikelEditScreen({
    Key? key,
    required this.id, 
    required this.initialJudul,
    required this.initialPendahuluan,
    required this.initialKonten,
    required this.initialImage,
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
          id: widget.id, 
          initialJudul: widget.initialJudul,
          initialPendahuluan: widget.initialPendahuluan,
          initialKonten: widget.initialKonten,
          initialImage: widget.initialImage,
        ),
      ),
    );
  }
}
