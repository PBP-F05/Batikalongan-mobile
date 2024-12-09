import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html'; // Untuk `File` di web.
import '../models/gallery_entry.dart';

class GalleryService {
  final String baseUrl;

  GalleryService(this.baseUrl);
  
  Future<bool> createGalleryEntry(Map<String, String> data, File image) async {
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/gallery/add/ajax/'));

    // Tambahkan field data
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    // Tambahkan file gambar
    final reader = FileReader();
    reader.readAsDataUrl(image);
    await reader.onLoadEnd.first;
    final bytes = reader.result as String;

    request.files.add(http.MultipartFile.fromBytes(
      'foto',
      base64Decode(bytes.split(',').last),
      filename: image.name,
    ));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString(); // Baca isi respons.

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Error Response (${response.statusCode}): $responseBody'); // Cetak error dari respons.
        return false;
      }
    } catch (e) {
      print('Error in createGalleryEntry: $e'); // Cetak error lokal.
      return false;
    }
  }

  Future<bool> editGalleryEntry(String id, Map<String, String> data, File? imageFile) async {
    final request = HttpRequest();
    final formData = FormData();

    // Tambahkan data teks.
    data.forEach((key, value) {
      formData.append(key, value);
    });

    // Tambahkan file gambar jika tersedia.
    if (imageFile != null) {
      formData.appendBlob('foto', imageFile);
    }

    request.open('POST', '$baseUrl/gallery/edit/$id/ajax/');
    request.send(formData);

    await request.onLoadEnd.first;

    return request.status == 200;
  }

  Future<Map<String, dynamic>> fetchGalleryEntries({int page = 1}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/gallery/json/?page=$page'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['entries'] is String) {
          final escapedEntries = data['entries'] as String;
          final entriesData = json.decode(escapedEntries) as List;
          final entries = entriesData.map((entry) => GalleryEntry.fromJson(entry)).toList();

          return {
            'entries': entries,
            'hasNext': data['has_next'],
            'hasPrevious': data['has_previous'],
            'currentPage': data['current_page'],
            'numPages': data['num_pages'],
          };
        } else {
          throw Exception('Invalid "entries" format in response.');
        }
      } else {
        throw Exception('Failed to load gallery entries with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching gallery entries: $e');
      rethrow;
    }
  }
}
