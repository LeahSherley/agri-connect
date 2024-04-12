import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MarketItems extends StatefulWidget {
  const MarketItems(
      {super.key, required this.items, required this.onSelectedItem});

  final Items items;
  final void Function() onSelectedItem;

  @override
  State<MarketItems> createState() => _MarketItemsState();
}

class _MarketItemsState extends State<MarketItems> {
  final List<CartItem> cartItems = [];

  void addToCart(Items items) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.items.id == items.id);

    if (existingItemIndex != -1) {
      // If item already exists in cart, increase its quantity
      setState(() {
        cartItems[existingItemIndex].quantity++;
      });
    } else {
      // If item does not exist in cart, add it as a new item
      setState(() {
        cartItems.add(CartItem(items: items));
        print('Cart items: $cartItems');
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.onSelectedItem,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colors.green[200]!,
              Colors.green[400]!,
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.items.img,
                width: double.infinity,
                height: 61.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 5.0,
              ),
              child: Text(
                widget.items.title,
                style: const TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 3.0),
              child: Text(
                widget.items.price,
                style: const TextStyle(
                  fontSize: 9.0,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  addToCart(widget.items);
                  ScaffoldMessenger.of(context).showSnackBar(
                    mySnackBar("Added to Cart!"),
                  );
                },
                icon: const Icon(
                  Icons.add_shopping_cart,
                  size: 20,
                )),
          ],
        ),
      ),
    );
  }
}
