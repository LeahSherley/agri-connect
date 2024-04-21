import 'dart:io';
import 'package:agri_tech/models/cart_items.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/shopping_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  //List <CartItem> cartItems = [];
  File? _selectedImage;

  void _imagePicker() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      await uploadImageToFirebaseStorage(_selectedImage!);
    }
  }

  Future<void> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child('${user!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageRef.putFile(imageFile);
      await storageRef.getDownloadURL();
    } catch (error) {
      print('Error uploading image to Firebase Storage: $error');
    }
  }

  late String _useremail = "";
  late String _username = "";

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final username = userData.data()!['username'];
        setState(() {
          _useremail = user.email ?? "";
          _username = username;
        });
      }
    } catch (error) {
      print(error);
    }
  }

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
              _username,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.green[100],
                fontFamily: GoogleFonts.gentiumPlus().fontFamily,
              ),
            ),
            accountEmail: Text(
              _useremail,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.green[100],
                fontFamily: GoogleFonts.gentiumPlus().fontFamily,
              ),
            ),
            currentAccountPicture: GestureDetector(
              onTap: _imagePicker,
              child: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.green[200],
                foregroundImage:
                    _selectedImage != null ? FileImage(_selectedImage!) : null,
                child: _selectedImage == null
                    ? const Icon(
                        Icons.account_circle_rounded,
                        size: 70,
                        color: Colors.green,
                      )
                    : null,
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
                      builder: (context) => ShoppingCart(
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
              onTap: () {
                FirebaseAuth.instance.signOut();
              }),
          const Divider(
            indent: 7.0,
            endIndent: 7.0,
          ),
        ],
      ),
    );
  }
}
