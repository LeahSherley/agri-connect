import 'dart:io';

import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, required this.items});
  final Items items;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  File? _image;
  final List<String> addresses = ['Address 1', 'Address 2', 'Address 3'];
  String selectedAddress = 'Address 1';

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
            'Checkout',
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
                readOnly: true,
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter product name',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green[300]!),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              mytext(
                'Product Photo:',
              ),
              _image != null
                  ? Image.file(
                      _image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[200],
                          ),
                          height: 150,
                          child: const Center(
                              child: Icon(
                            Icons.image_not_supported_rounded,
                          )),
                        );
                      },
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.photo,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              mytext(
                'Price:',
              ),
              TextField(
                readOnly: true,
                controller: priceController,
                decoration: InputDecoration(
                  hintText: 'Enter Price eg. 100',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.green[300]!),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              mytext(
                'Phone Number:',
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number e.g 07x xx xxx xxx',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              mytext(
                'Address:',
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedAddress,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAddress = newValue!;
                  });
                },
                items: addresses.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("${titleController.text} purchased!"));
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                  label: mytext("Proceed to Pay"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.green[100],
                    ),
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
