import 'package:agri_tech/models/comments.dart';
import 'package:agri_tech/providers/comments.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentSection extends ConsumerStatefulWidget {
  const CommentSection({Key? key, required this.postId}) : super(key: key);
  final String postId;

  @override
  ConsumerState<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends ConsumerState<CommentSection> {
  /*List<Comments> comments = [];*/
  void addCommentToFirestore(String postId, String commentInfo) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('comments').add({
        'postId': postId,
        'userId': user!.uid,
        'content': commentInfo,
      });
    } catch (error) {
      //print("$error");
    }
  }

  bool isLoading = false;
  /*Future<void> getCommentsForPost(String postId) async {
    try {
      setState(() {
        isLoading = true;
      });

      final commentSnapshot = await FirebaseFirestore.instance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .get();

      final List<Comments> comments = commentSnapshot.docs.map((doc) {
        return Comments(
          postId: doc['postId'],
          commentInfo: doc['content'],
        );
      }).toList();

      ref.read(commentsProvider.notifier).setComments(comments);
    } catch (error) {
      print("$error");
      setState(() {
        isLoading = false;
      });
    }
  }*/
  Future<void> getCommentsForPost(String postId) async {
    try {
      //final user = FirebaseAuth.instance.currentUser!;
      final commentSnapshot = await FirebaseFirestore.instance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .get();

      final List<Comments> comments = [];
      for (final doc in commentSnapshot.docs) {
        final commentData = doc.data();
        final userInfoSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(commentData['userId'])
            .get();

        final username = userInfoSnapshot.get('username');
        final comment = Comments(
          postId: commentData['postId'],
          commentInfo: commentData['content'],
          username: username,
        );
        comments.add(comment);
      }

      ref.read(commentsProvider.notifier).setComments(comments);
    } catch (error) {
      print("$error");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*final comments = ref.watch(commentsProvider);
    final postComments =
        comments.where((comment) => comment.postId == widget.postId).toList();*/
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        automaticallyImplyLeading: false,
        title: scaffoldtext('Comments'),
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: getCommentsForPost(widget.postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final comments = ref.watch(commentsProvider);
              final postComments = comments
                  .where((comment) => comment.postId == widget.postId)
                  .toList();
              return Column(
                children: [
                  Expanded(
                    child: postComments.isEmpty
                        ? Center(child: scaffoldtext("No comments!"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: postComments.length,
                            itemBuilder: (context, index) {
                              final comment = postComments[index];
                              return ListTile(
                                leading: CircleAvatar(
                                    child: Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.grey[700],
                                )),
                                title: Text(
                                  "@${comment.username}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey[700]),
                                ),
                                subtitle: Text(
                                  comment.commentInfo,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            /*setState(() {
                      comments.add(
                        Comments(
                            commentInfo: commentController.text,
                            postId: widget.postId),
                      );
                      commentController.clear();
                    });*/
                            ref.read(commentsProvider.notifier).addComment(
                                  Comments(
                                    commentInfo: commentController.text,
                                    postId: widget.postId,
                                  ),
                                );
                            addCommentToFirestore(
                                widget.postId, commentController.text);
                            commentController.clear();
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
