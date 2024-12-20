import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/entry_form.dart';

class ArtikelFormScreen extends StatelessWidget {
  const ArtikelFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<CookieRequest>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          width: double.infinity,
          height: 110,
          color: Colors.white,
          padding:
              const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align the title to the left
            children: [
              // Custom back button
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/back.svg', // Path to your SVG file
                  height: 40,
                  width: 40,
                ),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
              // Title with added left margin to shift it slightly
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0), // Add left padding to shift title
                child: Text(
                  'Tambah Artikel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Fabled',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the body in SingleChildScrollView for scrolling
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
