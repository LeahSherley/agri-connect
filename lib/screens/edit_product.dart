import 'dart:io';

import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/providers/products.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  const EditProductScreen({super.key, required this.items});
  final Items items;

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  File? _image;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.items.title);
    priceController = TextEditingController(text: widget.items.price);
    _image = File(widget.items.img);
  }

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
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
            'Edit Product',
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
                decoration: InputDecoration(
                  hintText: 'Enter Price eg. 100',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              mytext(
                'Add Photo:',
              ),
              _image != null
                  ? Image.file(
                      _image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Container(
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
                            _getImageFromGallery();
                          },
                          icon: const Icon(
                            Icons.photo,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 40,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    /*Navigator.pop(
                        context,
                        Items(
                          img: _image?.path ?? widget.items.img,
                          title: titleController.text,
                          price: priceController.text,
                        ));*/
                    final editedProduct = Items(
                      img: _image?.path ?? widget.items.img,
                      title: titleController.text,
                      price: priceController.text,
                    );
                    ref
                        .read(productStateProvider.notifier)
                        .editProduct(editedProduct);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(mySnackBar("Product Edited!"));
                    Navigator.pop(context);

                    titleController.clear();
                    priceController.clear();
                  },
                  icon: const Icon(
                    Icons.edit_note_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                  label: mytext("Save"),
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
