import 'package:agri_tech/models/community.dart';

import 'package:riverpod/riverpod.dart';

class ForumPostsNotifier extends StateNotifier<List<CommunityPost>> {
  ForumPostsNotifier() : super([]);

  void addPost(CommunityPost post) {
    final postIsAdded = state.contains(post);

    if (postIsAdded) {
      state = state.where((p) => p.caption != post.caption).toList();
    } else {
      state = [...state, post];
    }
  }

  void setPost(List<CommunityPost> post) {
    state = post;
  }
}

final forumPostsProvider =
    StateNotifierProvider<ForumPostsNotifier, List<CommunityPost>>(
  (ref) => ForumPostsNotifier(),
);
