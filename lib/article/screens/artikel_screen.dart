import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart'; // Tambahkan ini untuk menggunakan Provider
import 'artikel_form_screen.dart';
import '../widgets/artikel_card.dart';
import 'package:batikalongan_mobile/article/models/artikel_entry.dart';

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({Key? key}) : super(key: key);

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen> {
  Future<List<Article>> fetchArtikel(CookieRequest request) async {
    // Ganti URL sesuai endpoint API Anda
    final response = await request.get('http://127.0.0.1:8000/article/json/');

    // Decode response menjadi bentuk JSON
    var data = response;

    // Konversi data JSON menjadi objek ArtikelEntry
    List<Article> listArtikel = [];
    for (var d in data) {
      if (d != null) {
        listArtikel.add(Article.fromJson(d));
      }
    }
    return listArtikel;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel Batik'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newArtikel = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtikelFormScreen(),
                ),
              );
              if (newArtikel != null) {
                // Kirim data baru ke backend atau tambahkan langsung ke state
                // Contoh sederhana menambahkan ke list lokal:
                setState(() {
                  // Tambahkan newArtikel ke dalam listArtikel (jika local state digunakan)
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchArtikel(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada artikel yang tersedia.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final artikel = snapshot.data[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0), // Menambahkan jarak vertikal antar card
                  child: ArtikelCardWidget(
                    judul: artikel.fields.title,
                    pendahuluan: artikel.fields.introduction,
                    imagePath: artikel.fields.image,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
