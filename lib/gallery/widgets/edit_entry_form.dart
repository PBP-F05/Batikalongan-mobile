import 'package:flutter/material.dart';
import 'entry_form.dart';

class EditEntryForm extends StatelessWidget {
  final String entryId;
  final void Function(Map<String, dynamic>) onSubmit;

  const EditEntryForm({
    super.key,
    required this.entryId,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    // Similar to EntryForm but pre-filled data
    return EntryForm(onSubmit: onSubmit); // Example usage of reuse
  }
}
