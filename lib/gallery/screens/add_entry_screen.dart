import 'dart:html' as html; // Hanya untuk platform web.
import 'package:flutter/material.dart';
import '../services/gallery_service.dart';

class AddEntryScreen extends StatefulWidget {
  final VoidCallback onEntryAdded; // Callback untuk memberitahu perubahan.
  const AddEntryScreen({super.key, required this.onEntryAdded});

  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = GalleryService('https://faiz-assabil-batikalongantest.pbp.cs.ui.ac.id');
  final TextEditingController _namaBatikController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _asalUsulController = TextEditingController();
  final TextEditingController _maknaController = TextEditingController();

  html.File? _selectedImage; // Variable to store selected image file.

  Future<void> _pickImage() async {
    // File picker untuk web.
    final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final file = uploadInput.files?.first;
      if (file != null) {
        setState(() {
          _selectedImage = file;
        });
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih gambar terlebih dahulu')),
        );
        return;
      }

      try {
        final success = await _service.createGalleryEntry({
          'nama_batik': _namaBatikController.text,
          'deskripsi': _deskripsiController.text,
          'asal_usul': _asalUsulController.text,
          'makna': _maknaController.text,
        }, _selectedImage!);

        if (success) {
          widget.onEntryAdded(); // Panggil callback
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Berhasil menambahkan entri')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal menambahkan entri')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Batik')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaBatikController,
                decoration: const InputDecoration(labelText: 'Nama Batik'),
                validator: (value) => value == null || value.isEmpty ? 'Nama batik wajib diisi' : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              TextFormField(
                controller: _asalUsulController,
                decoration: const InputDecoration(labelText: 'Asal Usul'),
                validator: (value) => value == null || value.isEmpty ? 'Asal usul wajib diisi' : null,
              ),
              TextFormField(
                controller: _maknaController,
                decoration: const InputDecoration(labelText: 'Makna'),
                validator: (value) => value == null || value.isEmpty ? 'Makna wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pilih Gambar'),
              ),
              if (_selectedImage != null)
                Text(
                  'Gambar Terpilih: ${_selectedImage!.name}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
