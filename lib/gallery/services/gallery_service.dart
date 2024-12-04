import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gallery_entry.dart';

class GalleryService {
  final String baseUrl;

  GalleryService(this.baseUrl);

  Future<Map<String, dynamic>> fetchGalleryEntries({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/gallery/json/?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Decode entries (escaped JSON string)
      final escapedEntries = data['entries'] as String; // Entries adalah string JSON ter-escaped
      final entriesData = json.decode(escapedEntries) as List; // Decode string JSON menjadi List
      final entries = entriesData.map((entry) => GalleryEntry.fromJson(entry)).toList();

      // Return entries and pagination info
      return {
        'entries': entries,
        'hasNext': data['has_next'],
        'hasPrevious': data['has_previous'],
        'currentPage': data['current_page'],
        'numPages': data['num_pages'],
      };
    } else {
      throw Exception('Failed to load gallery entries');
    }
  }
}
