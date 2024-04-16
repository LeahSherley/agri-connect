import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCart extends ConsumerStatefulWidget {
  const ShoppingCart({super.key, required this.cartItems});

  final List<CartItem> cartItems;
  

  @override
  ConsumerState<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends ConsumerState<ShoppingCart> {

  /*void removeCart(CartItem itemToRemove) {
    setState(() {
      widget.cartItems
          .removeWhere((item) => item.items.id == itemToRemove.items.id);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: scaffoldtext('Shopping Cart'),
        backgroundColor: Colors.green[50],
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
      body: widget.cartItems.isEmpty
          ? Center(
              child: scaffoldtext("Cart is Empty!"),
            )
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return ListTile(
                  onTap: () {},
                  isThreeLine: true,
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        width: 80,
                        height: 80,
                        product.items.img,
                        fit: BoxFit.cover,
                      )),
                  title: Text(
                    product.items.title,
                    style: TextStyle(
                      color: Colors.green[800],
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Text(
                    product.items.price,
                    style: TextStyle(
                      color: Colors.green[200],
                      fontSize: 11,
                    ),
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Quantity: ${product.quantity}',
                      ),
                      IconButton(
                          onPressed: () {
                            //removeCart(product);
                            ref.read(shoppingCartProvider.notifier)
                             .removeCart(product.items);
                            ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                                "${product.items.title} removed from cart!"));
                          },
                          icon: const Icon(Icons.delete_outline_rounded,
                              size: 20)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
