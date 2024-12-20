import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../widgets/entry_form.dart';

class ArtikelFormScreen extends StatelessWidget {
  const ArtikelFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Artikel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ArtikelFormWidget(
          onSubmit: (artikel) {
            Navigator.pop(context, artikel);
          },
        ),
      ),
    );
  }
}
