import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/models/market_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartNotifier extends StateNotifier<List<CartItem>> {
  ShoppingCartNotifier() : super([]);

  void addToCart(Items item) {
    final existingCartItemIndex =
        state.indexWhere((cartItem) => cartItem.items.id == item.id);

    if (existingCartItemIndex != -1) {
      state[existingCartItemIndex].quantity++;
    } else {
      state.add(CartItem(
        items: item,
        quantity: 1,
      ));
    }
  }

  void removeCart(Items item) {
    final indexToRemove =
        state.indexWhere((cartItem) => cartItem.items.id == item.id);
    if (indexToRemove != -1) {
      state.removeAt(indexToRemove);
    }
  }
}


final shoppingCartProvider =
    StateNotifierProvider<ShoppingCartNotifier, List<CartItem>>(
  (ref) => ShoppingCartNotifier(),
);

