import 'package:batikalongan_mobile/gallery/screens/gallery_screen.dart';
import 'package:batikalongan_mobile/timeline/screens/timeline_screen.dart';
import 'package:batikalongan_mobile/widgets/bottom_navbar.dart';
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
  int _currentIndex = 3;

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
    final request = context.watch<CookieRequest>();

    String isAdmin = 'false';

    if (request.cookies['is_admin'] != null) {
           isAdmin = request.cookies['is_admin']!.value;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          width: double.infinity,
          height: 110,
          color: Colors.white,
          padding:
              const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Judul Artikel
              Expanded(
                child: Text(
                  'Artikel Batik',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Fabled',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),

              if (isAdmin == 'true')
                GestureDetector(
                  onTap: () async {
                    final newArtikel = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArtikelFormScreen(),
                      ),
                    );
                    if (newArtikel != null) {
                      setState(() {
                        artikelList =
                            fetchArtikel(context.read<CookieRequest>());
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 2, color: Color(0xFFD88E30)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add,
                            size: 24, color: Color(0xFFD88E30)),
                        const SizedBox(width: 8),
                        const Text(
                          'Tambah Artikel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD88E30),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
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
                    konten: artikel.content,
                    image: artikel.image,
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GalleryScreen()),
            );
          }
          if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TimeLineScreen()),
            );
          }
        },
      ),
    );
  }
}
