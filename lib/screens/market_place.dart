import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/screens/market_items.dart';
import 'package:agri_tech/screens/shopping_cart.dart';
import 'package:agri_tech/widgets/widgets.dart';
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
  List<CartItem> cartItems = [
   /* CartItem(
      items: Items(
        img:
            'https://www.groundsguys.com/us/en-us/grounds-guys/_assets/expert-tips/Organic-Fertilizer.webp',
        title: 'Ground Fertilizer',
        price: 'Ksh. 750',
      ),
      quantity: 2,
    ),
    CartItem(
      items: Items(
        img:
            'https://www.blfarm.com/wp-content/uploads/2018/02/hero-livestock-feed.jpg',
        title: 'Cattle Feed',
        price: 'Ksh. 300',
      ),
      quantity: 1,
    ),*/
  ];

  @override
  void initState() {
    super.initState();
    filteredItems = allitems;
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = allitems
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  final List<Items> allitems = [
    Items(
      img:
          'https://www.groundsguys.com/us/en-us/grounds-guys/_assets/expert-tips/Organic-Fertilizer.webp',
      title: 'Ground Fertilizer',
      price: 'Ksh. 750',
    ),
    Items(
      img:
          'https://www.blfarm.com/wp-content/uploads/2018/02/hero-livestock-feed.jpg',
      title: 'Cattle Feed',
      price: 'Ksh. 300',
    ),
    Items(
      img: 'https://agromaster.com/public/images/1606924470-0.jpg',
      title: 'Fertilizer Spreader',
      price: 'Ksh. 15,000',
    ),
    Items(
      img:
          'https://www.groundsguys.com/us/en-us/grounds-guys/_assets/expert-tips/Organic-Fertilizer.webp',
      title: 'Ground Fertilizer',
      price: 'Ksh. 750',
    ),
    Items(
      img:
          'https://www.blfarm.com/wp-content/uploads/2018/02/hero-livestock-feed.jpg',
      title: 'Cattle Feed',
      price: 'Ksh. 300',
    ),
    Items(
      img: 'https://agromaster.com/public/images/1606924470-0.jpg',
      title: 'Fertilizer Spreader',
      price: 'Ksh. 15,000',
    ),
    Items(
      img:
          'https://www.groundsguys.com/us/en-us/grounds-guys/_assets/expert-tips/Organic-Fertilizer.webp',
      title: 'Ground Fertilizer',
      price: 'Ksh. 750',
    ),
    Items(
      img:
          'https://www.blfarm.com/wp-content/uploads/2018/02/hero-livestock-feed.jpg',
      title: 'Cattle Feed',
      price: 'Ksh. 300',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(shoppingCartProvider);
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
      body: Column(
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                mainAxisExtent: 166,
              ),
              children: [
                for (final item in filteredItems)
                  MarketItems(
                    items: item,
                    onSelectedItem: () {},
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
