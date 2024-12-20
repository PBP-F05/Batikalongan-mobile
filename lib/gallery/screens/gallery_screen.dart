// import 'package:flutter/material.dart';
// import '../widgets/gallery_card.dart';
// import '../widgets/pagination_controls.dart';
// import '../services/gallery_service.dart';
// import '../models/gallery_entry.dart';
// import 'edit_entry_screen.dart';
// import 'add_entry_screen.dart';

// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key});

//   @override
//   _GalleryScreenState createState() => _GalleryScreenState();
// }

// class _GalleryScreenState extends State<GalleryScreen> {
//   final GalleryService _service = GalleryService('https://faiz-assabil-batikalongantest.pbp.cs.ui.ac.id'); // Base URL API
//   List<GalleryEntry> _entries = [];
//   int _currentPage = 1;
//   int _totalPages = 1;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchEntries();
//   }

//   Future<void> _fetchEntries({int page = 1}) async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final data = await _service.fetchGalleryEntries(page: page);
//       setState(() {
//         _entries = data['entries'];
//         _currentPage = data['currentPage'];
//         _totalPages = data['numPages'];
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       print('Error fetching entries: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Galeri Batik',
//           style: TextStyle(
//             fontFamily: 'Fabled', // Menggunakan font custom
//             color: Colors.black,
//             fontSize: 40,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   // Tombol tambah
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AddEntryScreen(
//                               onEntryAdded: _fetchEntries, // Refresh galeri
//                             ),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         side: const BorderSide(color: Color(0xFFD88E30), width: 2),
//                         backgroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         'Tambah Batik',
//                         style: TextStyle(
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                           color: Color(0xFFD88E30),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // ListView untuk Galeri Batik
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: _entries.length,
//                       itemBuilder: (context, index) {
//                         final entry = _entries[index];
//                         return GalleryCard(
//                           id: entry.id,
//                           namaBatik: entry.namaBatik,
//                           deskripsi: entry.deskripsi,
//                           asalUsul: entry.asalUsul,
//                           makna: entry.makna,
//                           fotoUrl: 'https://faiz-assabil-batikalongantest.pbp.cs.ui.ac.id/media/${entry.fotoUrl}',
//                           isAdmin: true,
//                           onEdit: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => EditEntryScreen(
//                                   entry: entry,
//                                   onEntryUpdated: _fetchEntries, // Refresh galeri
//                                 ),
//                               ),
//                             );
//                           },
//                           onDelete: () {
//                             // Logika delete
//                           },
//                         );
//                       },
//                     ),
//                   ),

//                   // Pagination Controls
//                   PaginationControls(
//                     currentPage: _currentPage,
//                     totalPages: _totalPages,
//                     onPageChange: (page) {
//                       _fetchEntries(page: page);
//                     },
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}