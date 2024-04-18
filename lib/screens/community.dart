import 'dart:io';

import 'package:agri_tech/models/community.dart';
import 'package:agri_tech/providers/community.dart';

import 'package:agri_tech/screens/add_post.dart';
import 'package:agri_tech/screens/comments.dart';
import 'package:agri_tech/screens/favorite_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Community extends ConsumerStatefulWidget {
  const Community({super.key});

  @override
  ConsumerState<Community> createState() => _CommunityState();
}

class _CommunityState extends ConsumerState<Community> {
  List<CommunityPost> post = [
    /*CommunityPost(
      id: "1",
      imgUrl:
          "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/23-03-2022_WHO_Kenya-3.jpg/image1170x530cropped.jpg",
      caption:
          "This is a sample post caption. Everything I prayed for and more!.",
    ),
    CommunityPost(
      id: "2",
      imgUrl:
          "https://bbeal.com/wp-content/uploads/2022/11/organic-farming-min.jpg",
      caption:
          "This is also a sample post caption of Everything I prayed for and more!.",
    ),
    CommunityPost(
      id: "3",
      imgUrl:
          "https://www.sudufarming.com/wp-content/uploads/2021/03/Organic-Farming.jpg",
      caption:
          "This is another simple post caption about Everything I prayed for and more.!",
    ),*/
  ];
  List<CommunityPost> favoritePosts = [];

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
                  const Text(
                    '@user',
                    style: TextStyle(
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
            post.isEmpty
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FractionallySizedBox(
                      //heightFactor:0,
                      child: Center(
                        child: scaffoldtext("Welcome Community Forum!"),
                      ),
                    ),
                  ],
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
                                  ? Image.network(
                                      posts.imgUrl,
                                      fit: BoxFit.cover,
                                      height: 150,
                                    )
                                  : Image.file(
                                      File(posts.imgUrl),
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
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
                                /*IconButton(
                            onPressed: () {
                              /*setState(() {
                                posts.isFavourite = !posts.isFavourite;
                                if (posts.isFavourite) {
                                  favoritePosts.add(posts);
                                } else {
                                  favoritePosts.remove(posts);
                                }
                              });*/
                              ref
                                  .read(favoritePostsProvider.notifier)
                                  .toggleFavorite(posts);
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
                          ),*/
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
