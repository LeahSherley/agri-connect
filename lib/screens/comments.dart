import 'package:agri_tech/models/comments.dart';
import 'package:agri_tech/providers/comments.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentSection extends ConsumerStatefulWidget {
  const CommentSection({Key? key, required this.postId}) : super(key: key);
  final String postId;

  @override
  ConsumerState<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends ConsumerState<CommentSection> {
  /*List<Comments> comments = [
    Comments(
      postId: "1",
      commentInfo: "This is about Everything I prayed for and more!",
    ),
    Comments(
      postId: "2",
      commentInfo: "This is also about Everything I prayed for and more!",
    ),
    Comments(
      postId: "3",
      commentInfo: "This is another one about Everything I prayed for and more!",
    ),
  ];*/
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider);
    final postComments =
        comments.where((comment) => comment.postId == widget.postId).toList();
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
      body: Column(
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
                          "User ${index + 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                        subtitle: Text(
                          comment.commentInfo,
                        ),
                      );
                    },
                  ),
          ),
          const Divider(height: 0),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
                    commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
