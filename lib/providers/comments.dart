import 'package:agri_tech/models/comments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsNotifier extends StateNotifier<List<Comments>> {
  CommentsNotifier() : super([]);

  void addComment(Comments comment) {
    state.add(comment);
  }

  void setComments(List<Comments> comments){
    state = comments;
  }
}


final commentsProvider =
    StateNotifierProvider<CommentsNotifier, List<Comments>>(
        (ref) => CommentsNotifier());
