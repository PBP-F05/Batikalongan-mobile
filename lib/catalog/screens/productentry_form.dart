// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:batikalongan_mobile/catalog/screens/menu.dart';
// import 'package:batikalongan_mobile/catalog/widgets/left_drawer.dart';
// import 'package:provider/provider.dart';

// class ProductEntryFormPage extends StatefulWidget {
//   const ProductEntryFormPage({super.key});

//   @override
//   State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
// }

// class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _productName = "";
//   String _description = "";
//   double _price = 0.0;

//   @override
//   Widget build(BuildContext context) {
//      final request = context.watch<CookieRequest>();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text('Form Tambah Produk Baru'),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Colors.white,
//       ),
//       drawer: const LeftDrawer(),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Nama Produk",
//                     labelText: "Nama Produk",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (String? value) {
//                     setState(() {
//                       _productName = value!;
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return "Nama Produk tidak boleh kosong!";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Deskripsi Produk",
//                     labelText: "Deskripsi",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   onChanged: (String? value) {
//                     setState(() {
//                       _description = value!;
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return "Deskripsi tidak boleh kosong!";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Harga Produk",
//                     labelText: "Harga",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                   onChanged: (String? value) {
//                     setState(() {
//                       _price = double.tryParse(value!) ?? 0.0;
//                     });
//                   },
//                   validator: (String? value) {
//                     if (value == null || value.isEmpty) {
//                       return "Harga tidak boleh kosong!";
//                     }
//                     if (double.tryParse(value) == null) {
//                       return "Harga harus berupa angka!";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: WidgetStateProperty.all(
//                           Theme.of(context).colorScheme.primary),
//                     ),
// onPressed: () async {
//     if (_formKey.currentState!.validate()) {
//         // Kirim ke Django dan tunggu respons
//         final response = await request.postJson(
//             "http://127.0.0.1/create-flutter/",
//             jsonEncode(<String, String>{
//                 'name': _productName,
//                 'description': _description,
//                 'price': _price.toString(),
//             }),
//         );
//         if (context.mounted) {
//             if (response['status'] == 'success') {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(const SnackBar(
//                 content: Text("Mood baru berhasil disimpan!"),
//                 ));
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => MyHomePage()),
//                 );
//             } else {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(const SnackBar(
//                     content:
//                         Text("Terdapat kesalahan, silakan coba lagi."),
//                 ));
//             }
//         }
//     }
// },

//                     child: const Text(
//                       "Simpan",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
