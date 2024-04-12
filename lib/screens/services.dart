import 'package:agri_tech/screens/add_product.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushReplacement<void, void>(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const AddProduct(),
            ),
          );
        },
        label: const Text("Add Product to MarketPlace"),
        icon: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.green[700],
            )),
        title: scaffoldtext(
          "My Products",
        ),
      ),
      body: Center(
        child: scaffoldtext("No Products Available!"),
      ),
    );
  }
}
