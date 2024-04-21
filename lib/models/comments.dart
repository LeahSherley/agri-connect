import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Comments {
  final String id;
  final String postId;
  final String commentInfo;
  final String? username;

  Comments({
    this.username,
    required this.postId,
    required this.commentInfo,
  }) : id = uuid.v4();
}
