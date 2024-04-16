import 'package:agri_tech/models/market_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductStateNotifier extends StateNotifier<List<Items>> {
  ProductStateNotifier() : super([]);

  void addProduct(Items item) {
    final isProductAdded = state.contains(item);
    if (isProductAdded) {
      state = state.where((i) => i.id != item.id).toList();
    } else {
      state = [...state, item];
    }
  }
  void removeProduct(Items item){
     state = state.where((i) => i.id != item.id).toList();
  }
}

final productStateProvider =
    StateNotifierProvider<ProductStateNotifier, List<Items>>(
        (ref) => ProductStateNotifier());
