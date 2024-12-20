// batikalongan_mobile/timeline/widgets/post_input.dart
import 'package:flutter/material.dart';

class PostInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final VoidCallback onSend;

  const PostInputWidget({
    Key? key,
    required this.controller,
    this.errorText,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Tulis pengalaman mu tentang batik hari ini',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
                hintMaxLines: 1,
                border: InputBorder.none,
                errorText: errorText,
              ),
            ),
          ),
          InkWell(
            onTap: onSend,
            child: const Icon(
              Icons.send_outlined,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
