import 'dart:io';

import 'package:agri_tech/models/community.dart';
import 'package:agri_tech/providers/community.dart';

import 'package:agri_tech/screens/add_post.dart';
import 'package:agri_tech/screens/comments.dart';
import 'package:agri_tech/screens/favorite_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Community extends ConsumerStatefulWidget {
  const Community({super.key});

  @override
  ConsumerState<Community> createState() => _CommunityState();
}

class _CommunityState extends ConsumerState<Community> {
  //List<CommunityPost> post = [];
  List<CommunityPost> favoritePosts = [];
  bool isLoading = false;
  late String _username = '';

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final postSnapshot =
          await FirebaseFirestore.instance.collection('posts').get();
      final List<CommunityPost> posts = postSnapshot.docs.map((doc) {
        return CommunityPost(
          id: doc.id,
          imgUrl: doc['imageUrl'] ?? '',
          caption: doc['caption'] ?? '',
          isLiked: doc['isLiked'] ?? '',
          isFavourite: doc['isFavorite'] ?? '',
        );
      }).toList();

      ref.read(forumPostsProvider.notifier).setPost(posts);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
    _getUserInfo();
  }
  void _getUserInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final username = userData.data()!['username'];
        setState(() {
          
          _username = username;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<CommunityPost> post = ref.watch(forumPostsProvider);
    //final List<CommunityPost> favoritePosts = ref.watch(favoritePostsProvider);

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[50],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.green[700],
              size: 28,
            )),
        title: scaffoldtext('Community'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '@$_username',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.green[50],
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return const AddPost();
                            },
                          );
                          if (result != null) {
                            /*setState(() {
                              post.add(result);
                            });*/
                            ref
                                .read(forumPostsProvider.notifier)
                                .addPost(result);
                          }
                        },
                        icon: const Icon(
                          Icons.add_rounded,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FavoritesPage(favoritePosts: favoritePosts),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.bookmarks_rounded,
                          color: Colors.green,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: post.length,
                    itemBuilder: (context, index) {
                      final posts = post[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: posts.imgUrl.startsWith("http")
                                  ? Image.network(posts.imgUrl,
                                      fit: BoxFit.cover,
                                      height: 150, errorBuilder:
                                          (context, error, stackTrace) {
                                      return Container(
                                        height: 150,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported_rounded,
                                          ),
                                        ),
                                      );
                                    })
                                  : Image.file(File(posts.imgUrl),
                                      height: 150,
                                      fit: BoxFit.cover, errorBuilder:
                                          (context, error, stackTrace) {
                                      return Container(
                                        height: 150,
                                        color: Colors.grey[300],
                                        child: const Center(
                                            child: Icon(
                                          Icons.image_not_supported_rounded,
                                        )),
                                      );
                                    }),
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      posts.isLiked = !posts.isLiked;
                                    });
                                  },
                                  icon: Icon(
                                    posts.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: posts.isLiked
                                        ? Colors.redAccent
                                        : Colors.grey[700],
                                    size: 18,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      backgroundColor: Colors.green[50],
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10.0)),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CommentSection(
                                          postId: posts.id,
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
                                      posts.isFavourite = !posts.isFavourite;
                                      if (posts.isFavourite) {
                                        favoritePosts.add(posts);
                                      } else {
                                        favoritePosts.remove(posts);
                                      }
                                    });
                                    /*ref
                                  .read(favoritePostsProvider.notifier)
                                  .toggleFavorite(posts);*/
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      mySnackBar(posts.isFavourite
                                          ? "Added to favorites!"
                                          : "Removed from favorites!"),
                                    );
                                  },
                                  icon: Icon(
                                    posts.isFavourite
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: posts.isFavourite
                                        ? Colors.amber
                                        : Colors.grey[700],
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            // Post caption
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                posts.caption,
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
                  )
          ],
        ),
      ),
    );
  }
}
