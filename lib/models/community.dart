import 'package:uuid/uuid.dart';

const uuid = Uuid();

class CommunityPost {
  final String imgUrl;
  final String caption;
  final String id;
  bool isLiked;
  bool isFavourite;

  CommunityPost({
    required this.imgUrl,
    required this.caption,
    String? id,
    this.isLiked = false,
    this.isFavourite = false,
  }) : id = id ?? uuid.v4();

  
}
