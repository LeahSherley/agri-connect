import 'dart:io';

import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
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
            'Add Product',
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
                'Product Name:',
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter product name',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              mytext(
                'Price:',
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter price: e.g 100',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              mytext(
                'Description:',
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter product description:',
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
                  onPressed: () {
                    final productName = titleController.text;
                    final productPrice = priceController.text;
                    final productDescription = descriptionController.text;
                    File? selectedImage = image;
                    if (image == null ||
                        titleController.text.isEmpty || descriptionController.text.isEmpty||
                        priceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Please Fill all fields!"),
                      );
                    } else {
                      Navigator.pop(
                          context,
                          Items(
                            img: selectedImage!.path,
                            title: productName,
                            price: productPrice,
                            description: productDescription,
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("Product Added!"),
                      );
                      titleController.clear();
                      priceController.clear();
                      descriptionController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.agriculture_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: mytext("Add Product"),
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
