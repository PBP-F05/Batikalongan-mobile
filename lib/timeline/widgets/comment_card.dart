// batikalongan_mobile/timeline/widgets/comment_card.dart
import 'package:flutter/material.dart';
import 'package:batikalongan_mobile/timeline/models/timeline.dart';

class CommentCardWidget extends StatelessWidget {
  final Comment comment;
  final String username;
  final VoidCallback onDeleteComment;

  const CommentCardWidget({
    Key? key,
    required this.comment,
    required this.username,
    required this.onDeleteComment,
  }) : super(key: key);

  String formatDate(String dateString) =>
      '${DateTime.parse(dateString).day.toString().padLeft(2, '0')}-${DateTime.parse(dateString).month.toString().padLeft(2, '0')}-${DateTime.parse(dateString).year}';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Comment Header: Author and Date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  comment.author,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  formatDate(comment.created.toString()),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            // Delete Comment Icon
            if (username == comment.author || username == 'admin1')
              InkWell(
                onTap: onDeleteComment,
                child: const Icon(
                  Icons.delete,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
        SizedBox(height: 5),
        // Comment Body
        Text(
          comment.body,
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
