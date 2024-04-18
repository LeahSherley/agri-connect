import 'dart:io';
import 'package:agri_tech/providers/products.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/add_product.dart';
import 'package:agri_tech/screens/edit_product.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Services extends ConsumerStatefulWidget {
  const Services({super.key});

  @override
  ConsumerState<Services> createState() => _ServicesState();
}

class _ServicesState extends ConsumerState<Services> {
  /*final List<Items> allitems = [
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
  ];*/
  /*void deleteItem(int index) {
    setState(() {
      allitems.removeAt(index);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final allitems = ref.watch(productStateProvider);
    return Scaffold(
      backgroundColor: Colors.green[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.green[50],
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return const AddProduct();
            },
          );
          if (result != null) {
            /*setState(() {
              allitems.add(result);
            });*/
            ref.read(productStateProvider.notifier).addProduct(result);
             
          }
        },
        label: const Text("Add Product to MarketPlace"),
        icon: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement<void, void>(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.green[700],
            )),
        title: scaffoldtext(
          "My Products",
        ),
      ),
      body: allitems.isEmpty
          ? Center(
              child: scaffoldtext("No Products Available!"),
            )
          : ListView.builder(
              itemCount: allitems.length,
              itemBuilder: (context, index) {
                var product = allitems[index];

                return ListTile(
                  onTap: () {},
                  isThreeLine: true,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: product.img.startsWith('http')
                        ? Image.network(
                            product.img,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(product.img),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          final result = await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.green[50],
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return EditProductScreen(items: product);
                            },
                          );
                          if (result != null) {
                            ref
                                .read(productStateProvider.notifier)
                                .editProduct(result);
                          }
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        "Kshs. ${product.price}",
                        style: TextStyle(
                          color: Colors.green[200],
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          //deleteItem(product));
                          ref
                              .read(productStateProvider.notifier)
                              .removeProduct(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackBar("${product.title} deleted!"),
                          );
                        },
                        icon:
                            const Icon(Icons.delete_outline_rounded, size: 22),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
