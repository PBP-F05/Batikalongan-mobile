import 'dart:html' as html; // Untuk platform web.
import 'package:flutter/material.dart';
import '../models/gallery_entry.dart';
import '../services/gallery_service.dart';

class EditEntryScreen extends StatefulWidget {
  final GalleryEntry entry;
  final VoidCallback onEntryUpdated; // Callback untuk memberitahu perubahan.
  const EditEntryScreen({
    super.key,
    required this.entry,
    required this.onEntryUpdated, // Tambahkan ke konstruktor.
  });

  @override
  _EditEntryScreenState createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = GalleryService('https://faiz-assabil-batikalongantest.pbp.cs.ui.ac.id');
  late TextEditingController _namaBatikController;
  late TextEditingController _deskripsiController;
  late TextEditingController _asalUsulController;
  late TextEditingController _maknaController;
  html.File? _selectedImage; // Variable to store selected image file.

  @override
  void initState() {
    super.initState();
    _namaBatikController = TextEditingController(text: widget.entry.namaBatik);
    _deskripsiController = TextEditingController(text: widget.entry.deskripsi);
    _asalUsulController = TextEditingController(text: widget.entry.asalUsul);
    _maknaController = TextEditingController(text: widget.entry.makna);
  }

  Future<void> _pickImage() async {
    // File picker for web.
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
      try {
        final success = await _service.editGalleryEntry(
          widget.entry.id,
          {
            'nama_batik': _namaBatikController.text,
            'deskripsi': _deskripsiController.text,
            'asal_usul': _asalUsulController.text,
            'makna': _maknaController.text,
          },
          _selectedImage, // Include selected image if available.
        );

        if (success) {
          widget.onEntryUpdated(); // Panggil callback
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update entry')),
          );
        }
      } catch (e) {
        // Print error and show message.
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Batik')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaBatikController,
                decoration: const InputDecoration(labelText: 'Nama Batik'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _asalUsulController,
                decoration: const InputDecoration(labelText: 'Asal Usul'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _maknaController,
                decoration: const InputDecoration(labelText: 'Makna'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pilih Gambar (Opsional)'),
              ),
              if (_selectedImage != null)
                Text(
                  'Gambar Terpilih: ${_selectedImage!.name}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
