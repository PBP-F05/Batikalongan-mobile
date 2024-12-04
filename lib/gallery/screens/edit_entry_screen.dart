import 'package:flutter/material.dart';
import '../widgets/edit_entry_form.dart';

class EditEntryScreen extends StatelessWidget {
  const EditEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Batik'),
      ),
      body: EditEntryForm(
        entryId: 'entry_1', // Placeholder for ID
        onSubmit: (data) {
          // Handle edit submission
        },
      ),
    );
  }
}
