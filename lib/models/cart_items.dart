import 'package:agri_tech/models/market_items.dart';

class CartItem {
  final Items items;
  int quantity;

  CartItem({
    required this.items,
    this.quantity = 1,
  });
}