// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:agri_tech/models/community.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? image;

  TextEditingController captionController = TextEditingController();

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('community_images')
          .child('${user!.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(imageFile);
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (error) {
      return null;
    }
  }

  void addPostToFirestore(String imageUrl, String caption) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('posts').add({
        'userId': user!.uid,
        'imageUrl': imageUrl,
        'caption': caption,
        'isLiked': false,
        'isFavorite': false,
      });
    } catch (error) {
      print("$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green[50],
          automaticallyImplyLeading: false,
          title: scaffoldtext(
            'Add Post',
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mytext(
                'Caption:',
              ),
              TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: 'Enter caption',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              mytext(
                'Add Photo:',
              ),
              image == null
                  ? Container(
                      width: double.infinity,
                      height: 150,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[100],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.photo,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  : Image.file(
                      image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 40,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final caption = captionController.text;
                    File? selectedImage = image;
                    if (image == null || captionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Please Fill all fields!"),
                      );
                    } else {
                      final imageUrl =
                          await uploadImageToFirebaseStorage(selectedImage!);
                      Navigator.pop(
                          context,
                          CommunityPost(
                            imgUrl: selectedImage.path,
                            caption: caption,
                          ));
                      addPostToFirestore(
                        imageUrl!,
                        caption,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Post Added to community!"),
                      );
                      captionController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.post_add_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: mytext("Add Post"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
