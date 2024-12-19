import 'dart:convert';

import 'package:batikalongan_mobile/article/screens/artikel_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditForm extends StatefulWidget {
  final int id;
  final String initialJudul;
  final String initialPendahuluan;
  final String initialKonten;
  final String initialImage;

  const EditForm({
    Key? key,
    required this.id,
    required this.initialJudul,
    required this.initialPendahuluan,
    required this.initialKonten,
    required this.initialImage,
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
    _judulController.text = widget.initialJudul;
    _pendahuluanController.text = widget.initialPendahuluan;
    _kontenController.text = widget.initialKonten;
    _selectedImage = null;
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        String base64Image = '';
        if (_selectedImage != null) {
          final imageBytes = await _selectedImage!.readAsBytes();
          base64Image = base64Encode(imageBytes);
        }

        final submittedData = {
          'id': widget.id,
          'title': _judulController.text,
          'introduction': _pendahuluanController.text,
          'content': _kontenController.text,
          'image': base64Image,
        };

        final response = await http.put(
          Uri.parse("http://127.0.0.1:8000/article/update-flutter/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(submittedData),
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Artikel berhasil diperbarui!")),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ArtikelScreen()),
              (route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Terdapat kesalahan, silakan coba lagi.")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${response.reasonPhrase}")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
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
