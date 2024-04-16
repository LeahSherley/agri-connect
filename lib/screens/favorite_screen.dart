import 'dart:io';

import 'package:agri_tech/models/community.dart';

import 'package:agri_tech/screens/comments.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final List<CommunityPost> favoritePosts;

  const FavoritesPage({Key? key, required this.favoritePosts})
      : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[50],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.green[700],
              size: 28,
            )),
        title: scaffoldtext('Favorites'),
      ),
      body: widget.favoritePosts.isEmpty
          ? Center(
              child: scaffoldtext("No Favourites Added!"),
            )
          : ListView.builder(
              itemCount: widget.favoritePosts.length,
              itemBuilder: (context, index) {
                final post = widget.favoritePosts[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: post.imgUrl.startsWith("http")
                            ? Image.network(
                                post.imgUrl,
                                fit: BoxFit.cover,
                                height: 150,
                              )
                            : Image.file(
                              File(post.imgUrl),
                              fit: BoxFit.cover, 
                              height: 150),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                post.isLiked = !post.isLiked;
                              });
                            },
                            icon: Icon(
                              post.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: post.isLiked
                                  ? Colors.redAccent
                                  : Colors.grey[700],
                              size: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showModalBottomSheet(
                                //isScrollControlled: true,
                                backgroundColor: Colors.green[50],
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return CommentSection(
                                    postId: post.id,
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.mode_comment_outlined,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                post.isFavourite = !post.isFavourite;
                                if (!post.isFavourite) {
                                  widget.favoritePosts.remove(post);
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  mySnackBar("Removed from favourites!"),
                                );
                              });
                            },
                            icon: Icon(
                              Icons.bookmark_remove_outlined,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      // Post caption
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          post.caption,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
