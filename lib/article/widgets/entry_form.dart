import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk JSON encoding/decoding
import 'package:batikalongan_mobile/article/screens/artikel_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ArtikelFormWidget extends StatefulWidget {
  final void Function(Map<String, String>) onSubmit;

  const ArtikelFormWidget({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ArtikelFormWidget> createState() => _ArtikelFormWidgetState();
}

class _ArtikelFormWidgetState extends State<ArtikelFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _pendahuluanController = TextEditingController();
  final _kontenController = TextEditingController();
  XFile? _selectedImage;

  @override
  void dispose() {
    _judulController.dispose();
    _pendahuluanController.dispose();
    _kontenController.dispose();
    super.dispose();
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
        // Menyiapkan data yang akan dikirim
        final submittedData = {
          'title': _judulController.text,
          'introduction': _pendahuluanController.text,
          'content': _kontenController.text,
          if (_selectedImage != null) 'imagePath': _selectedImage!.path,
        };

        // Kirim data ke backend menggunakan HTTP POST
        final response = await http.post(
          Uri.parse("http://127.0.0.1:8000/article/create-flutter/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(submittedData),
        );

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Artikel berhasil disimpan!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ArtikelScreen()),
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
