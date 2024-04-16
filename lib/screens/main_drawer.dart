import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  //List <CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    final List<CartItem> cartItems = ref.watch(shoppingCartProvider);
    return Drawer(
      elevation: 8.0,
      width: 300.0,
    
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "user",
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.green[100],
                fontFamily: GoogleFonts.gentiumPlus().fontFamily,

              ),
            ),
            accountEmail: Text(
              "user@gmail.com",
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.green[100],
                fontFamily: GoogleFonts.gentiumPlus().fontFamily,
              ),
            ),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: Hero(
                transitionOnUserGestures: true,
                tag: "My Profile Picture",
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.green[200],
                  child: const Icon(
                    Icons.account_circle_rounded,
                    size: 70,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green[400],
            ),
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.info_outline_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'About',
                selectionColor: Colors.green,
              ),
              onTap: () {}),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.8,
            ),
            leading: const Icon(
              Icons.call_rounded,
            ),
            title: const Text(
              style: TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              'Contact Us',
              selectionColor: Colors.green,
            ),
            onTap: () {},
          ),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.shopping_basket_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'Orders',
                selectionColor: Colors.green,
              ),
              onTap: () {}),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.shopping_cart,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'My Cart',
                selectionColor: Colors.green,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ShoppingCart(
                            cartItems: cartItems,
                          )),
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: -1.8,
              ),
              leading: const Icon(
                Icons.delete_rounded,
              ),
              title: const Text(
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                'Delete Account',
                selectionColor: Colors.green,
              ),
              onTap: () {
                const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                );
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
          ListTile(
            visualDensity: const VisualDensity(
              horizontal: 0,
              vertical: -1.8,
            ),
            leading: const Icon(
              Icons.login_outlined,
            ),
            title: const Text(
              style: TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              'Log Out',
              selectionColor: Colors.green,
            ),
            onTap: () {},
          ),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
        ],
      ),
    );
  }
}
