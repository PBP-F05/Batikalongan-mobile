import 'dart:convert';
import 'package:batikalongan_mobile/article/screens/artikel_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
        String base64Image = '';
        if (_selectedImage != null) {
          final imageBytes = await _selectedImage!.readAsBytes();
          base64Image = base64Encode(imageBytes);
        }

        final submittedData = {
          'title': _judulController.text,
          'introduction': _pendahuluanController.text,
          'content': _kontenController.text,
          'image': base64Image,
        };

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Field
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Judul Artikel',
              style: TextStyle(
                color: Color(0xFFD88E30), // Title color
                fontFamily: 'Poppins', // Apply Poppins font
              ),
            ),
          ),
          TextFormField(
            controller: _judulController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFD88E30)), // Always visible border color
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFD88E30)), // Always visible border color
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Judul tidak boleh kosong';
              }
              return null;
            },
            style: TextStyle(fontFamily: 'Poppins'), // Apply Poppins font
          ),
          const SizedBox(height: 16),
          // Foto Title
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Foto',
              style: TextStyle(
                color: Color(0xFFD88E30), // Title color
                fontFamily: 'Poppins', // Apply Poppins font
              ),
            ),
          ),
          // Image Picker
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(
                  Icons.upload, // Changed icon
                  color: Color(0xFFD88E30), // Icon color
                ),
                label: Text(
                  'Upload Foto',
                  style: TextStyle(
                    color: Color(0xFFD88E30), // Text color
                    fontFamily: 'Poppins', // Apply Poppins font
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  textStyle:
                      TextStyle(fontFamily: 'Poppins'), // Apply Poppins font
                  side: BorderSide(
                      color: Color(0xFFD88E30),
                      width: 1), // Border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (_selectedImage != null)
                Text(
                  'Gambar Dipilih',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontFamily: 'Poppins', // Apply Poppins font
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Pendahuluan Field
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Pendahuluan',
              style: TextStyle(
                color: Color(0xFFD88E30), // Title color
                fontFamily: 'Poppins', // Apply Poppins font
              ),
            ),
          ),
          TextFormField(
            controller: _pendahuluanController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFD88E30)), // Always visible border color
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFD88E30)), // Always visible border color
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pendahuluan tidak boleh kosong';
              }
              return null;
            },
            style: TextStyle(fontFamily: 'Poppins'), // Apply Poppins font
          ),
          const SizedBox(height: 16),
          // Konten Field
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Konten',
              style: TextStyle(
                color: Color(0xFFD88E30), // Title color
                fontFamily: 'Poppins', // Apply Poppins font
              ),
            ),
          ),
          TextFormField(
            controller: _kontenController,
            maxLines: 12,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFD88E30)), // Always visible border color
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFD88E30)), // Always visible border color
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Konten tidak boleh kosong';
              }
              return null;
            },
            style: TextStyle(fontFamily: 'Poppins'), // Apply Poppins font
          ),
          const SizedBox(height: 32),
          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD88E30),
                foregroundColor: Colors.white,
                fixedSize: Size(384, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle:
                    TextStyle(fontFamily: 'Poppins'), // Apply Poppins font
              ),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
