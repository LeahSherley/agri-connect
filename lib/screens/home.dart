import 'dart:convert';

import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/models/news_articles.dart';

import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/screens/main_drawer.dart';
import 'package:agri_tech/screens/market_place.dart';
import 'package:agri_tech/screens/news.dart';
import 'package:agri_tech/screens/notification_list.dart';
import 'package:agri_tech/screens/product_details.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  late String _username = "";
  late List<NewsArticles> articles = [];
  //List<NewsArticles> articles = [];
  final List<Items> products = [
    Items(
      img:
          'https://www.groundsguys.com/us/en-us/grounds-guys/_assets/expert-tips/Organic-Fertilizer.webp',
      title: 'Ground Fertilizer',
      price: '750',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at magna non elit tristique tempor. Integer ac fermentum enim. Donec eget ligula vel ligula lacinia fringilla. Aliquam scelerisque nisi sit amet justo vestibulum, id dapibus eros malesuada. Ut ac sapien id diam posuere luctus a id mi. Suspendisse potenti. Mauris feugiat, nisi nec sagittis tincidunt, lacus leo accumsan felis, nec lobortis felis elit nec tortor. Cras pharetra pretium nulla, vitae tristique felis lacinia ut. Aliquam sed vestibulum justo. Vivamus eleifend lacus libero, sed tempus ipsum scelerisque non. Integer varius, eros id tempor venenatis, justo arcu dignissim metus, ut feugiat metus nisl nec velit. Suspendisse sit amet sapien nisi. Sed eu est a urna efficitur vehicula. Sed sodales, quam eget accumsan congue, elit quam lacinia arcu, vitae scelerisque nunc erat a magna. Nunc nec nunc id justo rhoncus pretium.',
    ),
    Items(
      img:
          'https://www.blfarm.com/wp-content/uploads/2018/02/hero-livestock-feed.jpg',
      title: 'Cattle Feed',
      price: '300',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at magna non elit tristique tempor. Integer ac fermentum enim. Donec eget ligula vel ligula lacinia fringilla. Aliquam scelerisque nisi sit amet justo vestibulum, id dapibus eros malesuada. Ut ac sapien id diam posuere luctus a id mi. Suspendisse potenti. Mauris feugiat, nisi nec sagittis tincidunt, lacus leo accumsan felis, nec lobortis felis elit nec tortor. Cras pharetra pretium nulla, vitae tristique felis lacinia ut. Aliquam sed vestibulum justo. Vivamus eleifend lacus libero, sed tempus ipsum scelerisque non. Integer varius, eros id tempor venenatis, justo arcu dignissim metus, ut feugiat metus nisl nec velit. Suspendisse sit amet sapien nisi. Sed eu est a urna efficitur vehicula. Sed sodales, quam eget accumsan congue, elit quam lacinia arcu, vitae scelerisque nunc erat a magna. Nunc nec nunc id justo rhoncus pretium.',
    ),
    Items(
      img: 'https://agromaster.com/public/images/1606924470-0.jpg',
      title: 'Fertilizer Spreader',
      price: '15,000',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at magna non elit tristique tempor. Integer ac fermentum enim. Donec eget ligula vel ligula lacinia fringilla. Aliquam scelerisque nisi sit amet justo vestibulum, id dapibus eros malesuada. Ut ac sapien id diam posuere luctus a id mi. Suspendisse potenti. Mauris feugiat, nisi nec sagittis tincidunt, lacus leo accumsan felis, nec lobortis felis elit nec tortor. Cras pharetra pretium nulla, vitae tristique felis lacinia ut. Aliquam sed vestibulum justo. Vivamus eleifend lacus libero, sed tempus ipsum scelerisque non. Integer varius, eros id tempor venenatis, justo arcu dignissim metus, ut feugiat metus nisl nec velit. Suspendisse sit amet sapien nisi. Sed eu est a urna efficitur vehicula. Sed sodales, quam eget accumsan congue, elit quam lacinia arcu, vitae scelerisque nunc erat a magna. Nunc nec nunc id justo rhoncus pretium.',
    ),
  ];

  //late List<NewsArticles> filteredArticles;

  /*void filterArticles(String query) {
    setState(() {
      filteredArticles = articles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()) ||
              article.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }*/
  Future<void> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=farming&pageSize=10&apiKey=18db24f247fa4ac7ace17b952f149403'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        articles = List<NewsArticles>.from(jsonData['articles']
            .map((article) => NewsArticles.fromJson(article)));
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  void initState() {
    super.initState();
    //filteredArticles = articles;
    fetchArticles();
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
          _username = username;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      drawer: const MainDrawer(),
      key: scaffoldkey,
      appBar: AppBar(
        title: scaffoldtext("Home"),
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            if (scaffoldkey.currentState!.isDrawerOpen) {
              scaffoldkey.currentState!.closeDrawer();
            } else {
              scaffoldkey.currentState!.openDrawer();
            }
          },
          icon: Icon(
            Icons.account_circle_rounded,
            size: 30,
            color: Colors.green[700],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const NotificationList(),
              ));
            },
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                    children: [
                      Text(
                        "Hello $_username!",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    "Welcome to AgriConnect, Where every farmer matters!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                      height: 40,
                      child: search(
                        "Search",
                        searchController,
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        ),
                        //filterArticles,
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Products",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[300],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement<void, void>(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const MarketPlace(),
                              ),
                            );
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[300],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MarketItemDetailsPage(
                                    item: product,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green[100]!,
                                    Colors.green[300]!,
                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                ),
                              ),
                              margin: const EdgeInsets.only(right: 16),
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      product.img,
                                      width: double.infinity,
                                      height: 65.0,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: 61,
                                          color: Colors.grey[300],
                                          child: const Center(
                                              child: Icon(
                                            Icons.image_not_supported_rounded,
                                          )),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 5.0,
                                    ),
                                    child: Text(
                                      product.title,
                                      style: const TextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 3.0,
                                      //bottom: 5.0,
                                    ),
                                    child: Text(
                                      "Kshs. ${product.price}",
                                      style: const TextStyle(
                                        fontSize: 9.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 8.0,
                                        right: 8.0,
                                      ),
                                      child: ElevatedButton.icon(
                                          onPressed: () {
                                            ref
                                                .read(shoppingCartProvider
                                                    .notifier)
                                                .addToCart(product);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              mySnackBar("Added to Cart!"),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.add_shopping_cart,
                                            size: 15,
                                            color: Colors.grey[700],
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Colors.green[300],
                                              ),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ))),
                                          label: Text(
                                            "Add to cart",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[700],
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "News Feed",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[300],
                    ),
                  ),
                  articles.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement<void, void>(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        News(articles: article),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 16.0,
                                  top: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.green[100],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        article.urlToImage,
                                        width: double.infinity,
                                        height: 120.0,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 120,
                                            color: Colors.grey[200],
                                            child: Center(
                                                child: Icon(
                                              Icons.image_not_supported_rounded,
                                              color: Colors.green[700],
                                            )),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article.title,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article.description,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "By: ${article.author}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
