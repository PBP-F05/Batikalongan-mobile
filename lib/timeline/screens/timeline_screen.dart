import 'dart:convert';

import 'package:batikalongan_mobile/timeline/models/timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
                      'Belum ada data mood pada mental health tracker.',
                      style: TextStyle(fontSize: 20, color: Color(0xff59A5D8), fontFamily: 'Poppins',),
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
                        height: 300, // Set the height of the container
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/placeholder.jpg'),
                            fit: BoxFit.cover,  // Use BoxFit.cover or BoxFit.contain depending on your preference
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white.withOpacity(1), // Fully visible black at the bottom
                                Colors.white.withOpacity(0.4), // Transparent at the top
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                                color: Colors.white
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: postTextController,
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
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorText: _postErrorText,  // Show error text here
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (postTextController.text == "") {
                                        setState(() {
                                          _postErrorText = "Perlu diisi";
                                        });
                                      } else {
                                        final response = await request.postJson(
                                          "http://127.0.0.1:8000/timeline/create-post/",
                                          jsonEncode(<String, String>{
                                            'body' : postTextController.text
                                          }),
                                        );
                                        if (context.mounted) {
                                          if (response['status'] == 'success') {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Post created"),
                                            ));
                                            setState(() {
                                              _postErrorText = null;
                                              postTextController.text = "";
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("Terdapat kesalahan, silakan coba lagi."),
                                            ));
                                          }
                                        }
                                      }
                                    },
                                    child: const Icon(
                                      Icons.send_outlined,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40,),
                            Column(
                              children: List.generate(posts.length, (index) {
                                Post post = posts[index];

                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.orange),
                                        color: Colors.white
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
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
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    formatDate(post.created.toString()),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  )
                                                ],
                                              ),
                                              if (username == post.author)
                                                InkWell(
                                                  onTap: () async {
                                                    final response = await request.postJson(
                                                      "http://127.0.0.1:8000/timeline/delete-post/",
                                                      jsonEncode(<String, String>{'post_id': post.id}),
                                                    );
                                                    if (context.mounted) {
                                                      if (response['message'] == 'Post deleted') {
                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                          content: Text("Post deleted"),
                                                        ));
                                                        setState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                          content: Text("Terdapat kesalahan, silakan coba lagi."),
                                                        ));
                                                      }
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            post.body,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  final response = await request.postJson(
                                                    "http://127.0.0.1:8000/timeline/toggle-like/",
                                                    jsonEncode(<String, String>{'post_id': post.id}),
                                                  );
                                                  if (context.mounted) {
                                                    if (response['message'] == 'Post liked' || response['message'] == 'Like removed') {
                                                      // Use setState to refresh the widget without navigating away
                                                      setState(() {
                                                        // This will trigger the FutureBuilder to reload the data
                                                      });
                                                    } else {
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text("Terdapat kesalahan, silakan coba lagi."),
                                                      ));
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey.shade800),
                                                    borderRadius: BorderRadius.circular(25),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.favorite_border, size: 20),
                                                      SizedBox(width: 10),
                                                      Text(post.likeCount.toString())
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (postToComment != post.id) {
                                                      postToComment = post.id;
                                                    } else {
                                                      postToComment = "";
                                                    }
                                                    _commentErrorText = null;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey.shade800),
                                                    borderRadius: BorderRadius.circular(25)
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.mode_comment_outlined,
                                                        size: 20,
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Text(post.commentCount.toString())
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (postToComment == post.id)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10,),
                                                Divider(color: Colors.grey,),
                                                SizedBox(height: 10,),
                                                Text(
                                                  'Komentar',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30),
                                                    border: Border.all(color: Colors.grey),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: commentTextController,
                                                          maxLines: null,
                                                          decoration: InputDecoration(
                                                            hintText: 'Tulis komentarmu...',
                                                            hintStyle: const TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 14,
                                                              fontFamily: 'Poppins',
                                                            ),
                                                            hintMaxLines: 1,
                                                            border: InputBorder.none,
                                                            enabledBorder: InputBorder.none,
                                                            focusedBorder: InputBorder.none,
                                                            errorText: _commentErrorText,  // Show error text here
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (commentTextController.text.isEmpty) {
                                                            setState(() {
                                                              _commentErrorText = "Perlu diisi";
                                                            });
                                                          } else {
                                                            final response = await request.postJson(
                                                              "http://127.0.0.1:8000/timeline/create-comment/",
                                                              jsonEncode(<String, String>{
                                                                'body' : commentTextController.text,
                                                                'parent_post_id' : post.id
                                                              }),
                                                            );
                                                            if (context.mounted) {
                                                              if (response['status'] == 'success') {
                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                  content: Text("Post created"),
                                                                ));
                                                                setState(() {
                                                                  _commentErrorText = null;
                                                                  commentTextController.text = "";
                                                                });
                                                              } else {
                                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                  content: Text("Terdapat kesalahan, silakan coba lagi."),
                                                                ));
                                                              }
                                                            }
                                                          }
                                                        },
                                                        child: const Icon(
                                                          Icons.send_outlined,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Column(
                                                  children: List.generate(post.commentCount, (index) {
                                                    Comment comment = post.comments[index];
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
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
                                                                SizedBox(width: 10,),
                                                                Text(
                                                                  formatDate(comment.created.toString()),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontFamily: 'Poppins',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            if (username == comment.author)
                                                            InkWell(
                                                              onTap: () async {
                                                                final response = await request.postJson(
                                                                  "http://127.0.0.1:8000/timeline/delete-comment/",
                                                                  jsonEncode(<String, String>{'comment_id': comment.id}),
                                                                );
                                                                if (context.mounted) {
                                                                  if (response['message'] == 'Comment deleted') {
                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                      content: Text("Comment deleted"),
                                                                    ));
                                                                    setState(() {});
                                                                  } else {
                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                      content: Text("Terdapat kesalahan, silakan coba lagi."),
                                                                    ));
                                                                  }
                                                                }
                                                              },
                                                              child: const Icon (
                                                                Icons.delete,
                                                                size: 15,
                                                                color: Colors.grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(
                                                          comment.body,
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                          )
                                                        ),
                                                        SizedBox(height: 15,)
                                                      ],
                                                    );
                                                  }),
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20,)
                                  ],
                                );
                              }),
                            )
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