// batikalongan_mobile/timeline/widgets/post_card.dart
import 'package:flutter/material.dart';
import 'package:batikalongan_mobile/timeline/models/timeline.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'comment_input.dart';
import 'comment_card.dart';

class PostCardWidget extends StatelessWidget {
  final Post post;
  final String username;
  final String formattedDate;
  final Function onDeletePost;
  final Function onToggleLike;
  final Function onToggleComment;
  final Function onAddComment;
  final String postToComment;
  final TextEditingController commentController;
  final String? commentErrorText;
  final Function onDeleteComment;

  const PostCardWidget({
    Key? key,
    required this.post,
    required this.username,
    required this.formattedDate,
    required this.onDeletePost,
    required this.onToggleLike,
    required this.onToggleComment,
    required this.onAddComment,
    required this.postToComment,
    required this.commentController,
    this.commentErrorText,
    required this.onDeleteComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCommenting = postToComment == post.id;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Author and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        post.author,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  // Delete Post Icon
                  if (username == post.author || username == 'admin1')
                    InkWell(
                      onTap: () => onDeletePost(),
                      child: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10),
              // Post Body
              Text(
                post.body,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 10),
              // Like and Comment Buttons
              Row(
                children: [
                  InkWell(
                    onTap: () => onToggleLike(),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border, size: 20),
                          SizedBox(width: 10),
                          Text(post.likeCount.toString()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () => onToggleComment(),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mode_comment_outlined,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(post.commentCount.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Comment Section
              if (isCommenting) ...[
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'Komentar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 20),
                CommentInputWidget(
                  controller: commentController,
                  errorText: commentErrorText,
                  onSend: () => onAddComment(),
                ),
                SizedBox(height: 20),
                // List of Comments
                Column(
                  children: List.generate(post.comments.length, (index) {
                    Comment comment = post.comments[index];
                    return CommentCardWidget(
                      comment: comment,
                      username: username,
                      onDeleteComment: () => onDeleteComment(comment.id),
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
