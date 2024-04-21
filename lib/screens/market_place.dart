import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/providers/products.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/screens/market_items.dart';
import 'package:agri_tech/screens/product_details.dart';
import 'package:agri_tech/screens/shopping_cart.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketPlace extends ConsumerStatefulWidget {
  const MarketPlace({super.key});

  @override
  ConsumerState<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends ConsumerState<MarketPlace> {
  TextEditingController searchController = TextEditingController();

  late List<Items> filteredItems;
  final List<Items> allitems = [];
  bool isLoading = false;
  //List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allitems;
    fetchProducts();
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = allitems
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      final productsSnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      final List<Items> products = productsSnapshot.docs.map((doc) {
        return Items(
          img: doc['imageUrl'] ?? '',
          title: doc['name'] ?? '',
          price: doc['price'] ?? '',
          description: doc['description'] ?? '',
        );
      }).toList();

      ref.read(productStateProvider.notifier).setProduct(products);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      //print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(shoppingCartProvider);
    final filteredItems = ref.watch(productStateProvider);
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        centerTitle: true,
        title: scaffoldtext("MarketPlace"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.green[800],
            size: 28,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          : filteredItems.isEmpty
              ? Center(
                  child: scaffoldtext("MarketPlace is empty!"),
                )
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 18,
                        top: 10,
                      ),
                      height: 40,
                      child: search(
                        "Search Products",
                        searchController,
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                        filterItems,
                      ),
                    ),
                    Expanded(
                      child: GridView(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 20,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                        children: [
                          for (final item in filteredItems)
                            MarketItems(
                              items: item,
                              onSelectedItem: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        MarketItemDetailsPage(item: item),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ShoppingCart(cartItems: cartItems)),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
