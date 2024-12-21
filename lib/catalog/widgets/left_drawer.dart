// import 'package:flutter/material.dart';
// import 'package:batikalongan_mobile/catalog/screens/list_product.dart';
// import 'package:batikalongan_mobile/catalog/screens/menu.dart';
// import 'package:batikalongan_mobile/catalog/screens/productentry_form.dart';

// class LeftDrawer extends StatelessWidget {
//   const LeftDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(4
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             child: const Column(
//               children: [
//                 Text(
//                   'Prime Cart',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.all(8)),
//                 Text("Ayo belanja sepuasnya di sini!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.white,
//                     )),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home_outlined),
//             title: const Text('Halaman Utama'),
//             // Bagian redirection ke MyHomePage
//             onTap: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => MyHomePage(),
//                   ));
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.add),
//             title: const Text('Tambah Produk'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProductEntryFormPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.add_reaction_rounded),
//             title: const Text('Lihat Daftar Produk'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ProductPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
