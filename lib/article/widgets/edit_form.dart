import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditForm extends StatefulWidget {
  final String initialJudul;
  final String initialPendahuluan;
  final String initialKonten;
  final String initialImagePath;
  final void Function(Map<String, String>) onSubmit;

  const EditForm({
    Key? key,
    required this.initialJudul,
    required this.initialPendahuluan,
    required this.initialKonten,
    required this.initialImagePath,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _pendahuluanController = TextEditingController();
  final _kontenController = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data awal yang diterima dari ArtikelEditScreen
    _judulController.text = widget.initialJudul;
    _pendahuluanController.text = widget.initialPendahuluan;
    _kontenController.text = widget.initialKonten;
    _selectedImage = widget.initialImagePath.isNotEmpty
        ? XFile(widget.initialImagePath)
        : null; // Set gambar awal jika ada
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Menyiapkan data yang akan dikirim setelah edit
      final editedData = {
        'title': _judulController.text,
        'introduction': _pendahuluanController.text,
        'content': _kontenController.text,
        if (_selectedImage != null) 'imagePath': _selectedImage!.path,
      };

      widget.onSubmit(editedData); // Memanggil onSubmit untuk mengirim data
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pendahuluanController.dispose();
    _kontenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Field
          TextFormField(
            controller: _judulController,
            decoration: const InputDecoration(
              labelText: 'Judul Artikel',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Judul tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Image Picker
          Row(
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pilih Gambar'),
              ),
              const SizedBox(width: 16),
              if (_selectedImage != null)
                Text(
                  'Gambar Dipilih',
                  style: TextStyle(color: Colors.green[700]),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Pendahuluan Field
          TextFormField(
            controller: _pendahuluanController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Pendahuluan',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pendahuluan tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Konten Field
          TextFormField(
            controller: _kontenController,
            maxLines: 15,
            decoration: const InputDecoration(
              labelText: 'Konten',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Konten tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
