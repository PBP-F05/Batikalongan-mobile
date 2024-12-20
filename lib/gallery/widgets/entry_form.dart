import 'package:flutter/material.dart';

class EntryForm extends StatelessWidget {
  final void Function(Map<String, dynamic>) onSubmit;
  final Map<String, dynamic>? initialData;

  const EntryForm({
    super.key,
    required this.onSubmit,
    this.initialData,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final Map<String, dynamic> _data = initialData ?? {}; // Pastikan _data memiliki tipe Map<String, dynamic>

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _data['nama_batik'] ?? '', // Gunakan data awal jika ada
                decoration: const InputDecoration(labelText: 'Nama Batik'),
                onSaved: (value) => _data['nama_batik'] = value ?? '',
              ),
              // Tambahkan field lain seperti deskripsi, makna, dll.
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    onSubmit(_data); // Kirim data ke fungsi onSubmit
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
