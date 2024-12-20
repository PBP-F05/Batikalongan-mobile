// batikalongan_mobile/timeline/screens/timeline_screen.dart
import 'dart:convert';

import 'package:batikalongan_mobile/timeline/models/timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:batikalongan_mobile/timeline/widgets/post_input.dart';
import 'package:batikalongan_mobile/timeline/widgets/post_card.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({super.key});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  TextEditingController postTextController = TextEditingController();
  TextEditingController commentTextController = TextEditingController();
  String? _postErrorText;
  String? _commentErrorText;
  String postToComment = "";

  String formatDate(String dateString) =>
      '${DateTime.parse(dateString).day.toString().padLeft(2, '0')}-${DateTime.parse(dateString).month.toString().padLeft(2, '0')}-${DateTime.parse(dateString).year}';

  Future<List<Post>> fetchTimeLineData(CookieRequest request) async {
    List<Post> posts = [];
    final response = await request.get('http://127.0.0.1:8000/timeline/json/');

    for (var json in response) {
      posts.add(Post.fromJson(json));
    }
    if (kDebugMode) {
      print("Data fetched from Backend");
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final username = request.getJsonData()['username'];

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: fetchTimeLineData(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      'Belum ada data komentar...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff59A5D8),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                List<Post> posts = snapshot.data!;

                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/placeholder.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white.withOpacity(1),
                                Colors.white.withOpacity(0.4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            // Post Input Section
                            PostInputWidget(
                              controller: postTextController,
                              errorText: _postErrorText,
                              onSend: () async {
                                if (postTextController.text.isEmpty) {
                                  setState(() {
                                    _postErrorText = "Perlu diisi";
                                  });
                                } else {
                                  final response = await request.postJson(
                                    "http://127.0.0.1:8000/timeline/create-post/",
                                    jsonEncode(<String, String>{
                                      'body': postTextController.text
                                    }),
                                  );
                                  if (context.mounted) {
                                    if (response['status'] == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Post created"),
                                      ));
                                      setState(() {
                                        _postErrorText = null;
                                        postTextController.text = "";
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "Terdapat kesalahan, silakan coba lagi."),
                                      ));
                                    }
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 40),
                            // List of Posts
                            Column(
                              children: List.generate(posts.length, (index) {
                                Post post = posts[index];
                                String formattedDate =
                                    formatDate(post.created.toString());

                                return PostCardWidget(
                                  post: post,
                                  username: username,
                                  formattedDate: formattedDate,
                                  onDeletePost: () async {
                                    final response =
                                        await request.postJson(
                                      "http://127.0.0.1:8000/timeline/delete-post/",
                                      jsonEncode(<String, String>{
                                        'post_id': post.id
                                      }),
                                    );
                                    if (context.mounted) {
                                      if (response['message'] == 'Post deleted') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Post deleted"),
                                        ));
                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Terdapat kesalahan, silakan coba lagi."),
                                        ));
                                      }
                                    }
                                  },
                                  onToggleLike: () async {
                                    final response = await request.postJson(
                                      "http://127.0.0.1:8000/timeline/toggle-like/",
                                      jsonEncode(<String, String>{
                                        'post_id': post.id
                                      }),
                                    );
                                    if (context.mounted) {
                                      if (response['message'] ==
                                              'Post liked' ||
                                          response['message'] ==
                                              'Like removed') {
                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Terdapat kesalahan, silakan coba lagi."),
                                        ));
                                      }
                                    }
                                  },
                                  onToggleComment: () {
                                    setState(() {
                                      if (postToComment != post.id) {
                                        postToComment = post.id;
                                      } else {
                                        postToComment = "";
                                      }
                                      _commentErrorText = null;
                                    });
                                  },
                                  onAddComment: () async {
                                    if (commentTextController.text.isEmpty) {
                                      setState(() {
                                        _commentErrorText = "Perlu diisi";
                                      });
                                    } else {
                                      final response = await request.postJson(
                                        "http://127.0.0.1:8000/timeline/create-comment/",
                                        jsonEncode(<String, String>{
                                          'body': commentTextController.text,
                                          'parent_post_id': post.id
                                        }),
                                      );
                                      if (context.mounted) {
                                        if (response['status'] == 'success') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("Komentar dibuat"),
                                          ));
                                          setState(() {
                                            _commentErrorText = null;
                                            commentTextController.text = "";
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Terdapat kesalahan, silakan coba lagi."),
                                          ));
                                        }
                                      }
                                    }
                                  },
                                  postToComment: postToComment,
                                  commentController: commentTextController,
                                  commentErrorText: _commentErrorText,
                                  onDeleteComment: (commentId) async {
                                    final response = await request.postJson(
                                      "http://127.0.0.1:8000/timeline/delete-comment/",
                                      jsonEncode(<String, String>{
                                        'comment_id': commentId
                                      }),
                                    );
                                    if (context.mounted) {
                                      if (response['message'] ==
                                          'Comment deleted') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Comment deleted"),
                                        ));
                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Terdapat kesalahan, silakan coba lagi."),
                                        ));
                                      }
                                    }
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
