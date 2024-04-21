import 'package:agri_tech/screens/checkout.dart';
import 'package:agri_tech/screens/market_place.dart';
import 'package:agri_tech/screens/my_orders.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:agri_tech/models/market_items.dart';

class MarketItemDetailsPage extends StatefulWidget {
  final Items item;

  const MarketItemDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  State<MarketItemDetailsPage> createState() => _MarketItemDetailsPageState();
}

class _MarketItemDetailsPageState extends State<MarketItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MarketPlace(),
              ),
            );
          },
        ),
        title: scaffoldtext(widget.item.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.item.img,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 150.0,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            size: 60.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Kshs. ${widget.item.price}",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                textAlign: TextAlign.justify,
                widget.item.description,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100], // Set button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set border radius
                      ),
                    ),
                    onPressed: () async {
                      final result = await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.green[50],
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Checkout(items:widget.item);
                        },
                      );
                      if (result != null) {
                        setState(() {
                          //widget.item.add(result);
                        });
                      }
                    },
                    child: const Text('Checkout'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
