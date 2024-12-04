import 'package:flutter/material.dart';
import '../widgets/entry_form.dart';

class AddEntryScreen extends StatelessWidget {
  const AddEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Batik Baru'),
      ),
      body: EntryForm(
        onSubmit: (data) {
          // Handle form submission
        },
      ),
    );
  }
}
