import 'package:batikalongan_mobile/article/screens/artikel_detail_screen.dart';
import 'package:batikalongan_mobile/article/screens/artikel_edit_screen.dart';
import 'package:batikalongan_mobile/article/screens/artikel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ArtikelCardWidget extends StatelessWidget {
  final int id;
  final String judul;
  final String pendahuluan;
  final String konten;
  final String image;

  const ArtikelCardWidget({
    Key? key,
    required this.id,
    required this.judul,
    required this.pendahuluan,
    required this.konten,
    required this.image,
  }) : super(key: key);

  Future<void> _deleteArtikel(BuildContext context) async {
    final String url = 'http://127.0.0.1:8000/article/delete-flutter/$id';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Artikel berhasil dihapus')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ArtikelScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus artikel')),
        );
      }
    } catch (e) {
      print('Error deleting article: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat menghapus artikel')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    String isAdmin = 'false';

    if (request.cookies['is_admin'] != null) {
      isAdmin = request.cookies['is_admin']!.value;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar Header
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 111,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: _getImageProvider(image),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Tombol Edit dan Delete
                if (isAdmin == 'true')
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/edit.svg',
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtikelEditScreen(
                                  id: id,
                                  initialJudul: judul,
                                  initialPendahuluan: pendahuluan,
                                  initialKonten: konten,
                                  initialImage: image,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/delete.svg',
                          ),
                          onPressed: () {
                            _deleteArtikel(context);
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(color: Color(0xFFD9D9D9), width: 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pendahuluan,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  // Tombol Lihat Artikel
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtikelDetailScreen(
                            judul: judul,
                            konten: konten,
                            image: image,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD88E30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lihat Artikel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String image) {
    if (image.isEmpty) {
      return const AssetImage('images/placeholder.jpg');
    } else {
      try {
        final bytes = base64Decode(image);
        return MemoryImage(bytes);
      } catch (e) {
        return const AssetImage('images/placeholder.jpg');
      }
    }
  }
}
