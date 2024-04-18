import 'package:agri_tech/models/news_articles.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class News extends ConsumerStatefulWidget {
  const News({super.key, required this.articles});
  final NewsArticles articles;

  @override
  ConsumerState<News> createState() => _NewsState();
}

bool isFavourite = false;

class _NewsState extends ConsumerState<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 12),
              icon: Icon(
                isFavourite ? Icons.star : Icons.star_outline,
                color: isFavourite ? Colors.amber : Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  isFavourite = !isFavourite;
                });
              }),
        ],
        elevation: 8.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.green),
        ),
        title: scaffoldtext(widget.articles.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(15),
              child: Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(widget.articles.urlToImage,),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black54,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 44, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.articles.title,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                /*boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurStyle: BlurStyle.normal,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],*/
                gradient: LinearGradient(
                  colors: [
                    Colors.green[100]!,
                    Colors.green[50]!,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      softWrap: true,
                      widget.articles.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      softWrap: true,
                      widget.articles.content,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height:10,),
                    Text(
                      softWrap: true,
                      "By: ${widget.articles.author}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 11,
                        fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: '© ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.gentiumPlus().fontFamily,
                ),
                children: [
                  TextSpan(
                    text: 'AgriConnect',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.gentiumPlus().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
