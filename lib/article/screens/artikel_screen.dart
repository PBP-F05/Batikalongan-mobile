import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'artikel_form_screen.dart';
import '../widgets/artikel_card.dart';
import 'package:batikalongan_mobile/article/models/artikel_entry.dart';

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({Key? key}) : super(key: key);

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen>
    with WidgetsBindingObserver {
  late Future<List<Article>> artikelList;

  @override
  void initState() {
    super.initState();
    artikelList = fetchArtikel(context.read<CookieRequest>());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        artikelList = fetchArtikel(context.read<CookieRequest>());
      });
    }
  }

  Future<List<Article>> fetchArtikel(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/article/json/');

    var data = response;

    if (data is Map<String, dynamic> && data.containsKey('articles')) {
      List<Article> listArtikel = [];

      var articles = data['articles'];
      if (articles is List) {
        for (var d in articles) {
          if (d != null) {
            listArtikel.add(Article.fromJson(d));
          }
        }
      }
      return listArtikel;
    } else {
      throw Exception('Unexpected response format');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => const ArtikelFormScreen(),
                ),
              );
              if (newArtikel != null) {
                setState(() {
                  artikelList = fetchArtikel(context.read<CookieRequest>());
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: artikelList,
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ArtikelCardWidget(
                    id: artikel.id,
                    judul: artikel.title,
                    pendahuluan: artikel.introduction,
                    image: artikel.image,
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
