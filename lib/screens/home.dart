import 'package:agri_tech/models/news_articles.dart';
import 'package:agri_tech/models/products.dart';
import 'package:agri_tech/screens/main_drawer.dart';
import 'package:agri_tech/screens/market_place.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  List<NewsArticles> articles = [
    NewsArticles(
      imageUrl:
          'https://www.farmafrica.org/images/blogs/juliet-and-goats-kenya.jpg',
      title: 'News Title 1',
      description: 'Description of news article 1',
    ),
    NewsArticles(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA9hGApixKyGfKLQpU3JV1WjU-J9T3XyL86awxO9oKRUejlp5_FzO73iW78BF3ioVfBY4&usqp=CAU',
      title: 'News Title 2',
      description: 'Description of news article 2',
    ),
    NewsArticles(
      imageUrl:
          'https://media.licdn.com/dms/image/C5612AQHTZ8u04G8cgg/article-inline_image-shrink_400_744/0/1617441359282?e=1717632000&v=beta&t=RHsE5TfwTrrMX-BB27oH49DlaHEPiDCqmsjYJmYtSuo',
      title: 'News Title 3',
      description: 'Description of news article 3',
    ),
    NewsArticles(
      imageUrl:
          'https://www.shutterstock.com/image-photo/tractor-spraying-pesticides-on-soybean-600nw-653708227.jpg',
      title: 'News Title 4',
      description: 'Description of news article 4',
    ),
  ];

  List<FeaturedProducts> products = [
    FeaturedProducts(
      img:
          'https://www.groundsguys.com/us/en-us/grounds-guys/_assets/expert-tips/Organic-Fertilizer.webp',
      title: 'Ground Fertilizer',
      price: 'Ksh. 750',
    ),
    FeaturedProducts(
      img:
          'https://www.blfarm.com/wp-content/uploads/2018/02/hero-livestock-feed.jpg',
      title: 'Cattle Feed',
      price: 'Ksh. 300',
    ),
    FeaturedProducts(
      img: 'https://agromaster.com/public/images/1606924470-0.jpg',
      title: 'Fertilizer Spreader',
      price: 'Ksh. 15,000',
    ),
  ];

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
            onPressed: () {},
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
                  const Row(
                    children: [
                      Text(
                        "Hello user!",
                        style: TextStyle(
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
                    height: 155,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {},
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
                              margin: const EdgeInsets.only(right: 16),
                              width: 120,
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
                                    ),
                                    child: Text(
                                      product.price,
                                      style: const TextStyle(
                                        fontSize: 9.0,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        // addToCart(widget.items);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                    "Agriculture News",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[300],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 16.0,
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    article.imageUrl,
                                    width: double.infinity,
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    article.description,
                                    style: const TextStyle(
                                      fontSize: 12.0,
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
