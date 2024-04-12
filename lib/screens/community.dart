import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        leading: IconButton(
            onPressed: () {},
            icon:  Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.green[700],
              size: 28,
            )),
        title: scaffoldtext('Community'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/splash_screen-removebg-preview.png",
                    ),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '@user',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_rounded,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://truust.io/wp-content/uploads/2017/04/community.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.mode_comment_outlined,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon:  Icon(
                              Icons.bookmark_border,
                              color: Colors.grey[700],
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      // Post caption
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'This is a sample post caption. Everything I prayed for and more!.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
