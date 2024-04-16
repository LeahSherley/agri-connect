import 'package:uuid/uuid.dart';

const uuid = Uuid();
class Items {
  final String id;
  final String img;
  final String title;
  final String price;

  Items({
    required this.img,
    required this.title,
    required this.price,
  } ): id = uuid.v4();
}