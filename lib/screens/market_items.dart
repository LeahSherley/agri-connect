import 'dart:io';
import 'package:agri_tech/models/market_items.dart';
import 'package:agri_tech/providers/shopping_cart.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketItems extends ConsumerStatefulWidget {
  const MarketItems({
    super.key,
    required this.items,
    required this.onSelectedItem,
    this.showDescription = true,
  });

  final Items items;
  final void Function() onSelectedItem;
  final bool showDescription;

  @override
  ConsumerState<MarketItems> createState() => _MarketItemsState();
}

class _MarketItemsState extends ConsumerState<MarketItems> {
  //final List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    //final cartItems = ref.watch(shoppingCartProvider);
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.onSelectedItem,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: widget.items.img.startsWith('http')
                  ? Image.network(
                      widget.items.img,
                      width: double.infinity,
                      height: 110.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 110,
                          color: Colors.grey[300],
                          child: Center(
                              child: Icon(Icons.image_not_supported_rounded,
                                  color: Colors.grey[700])),
                        );
                      },
                    )
                  : Image.file(
                      File(widget.items.img),
                      width: double.infinity,
                      height: 110.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 110,
                          color: Colors.grey[300],
                          child: Center(
                              child: Icon(Icons.image_not_supported_rounded,
                                  color: Colors.grey[700])),
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
                widget.items.title,
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
                bottom: 10.0,
              ),
              child: Text(
                "Kshs. ${widget.items.price}",
                style: const TextStyle(
                  fontSize: 9.0,
                ),
              ),
            ),
            if (!widget.showDescription)
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  widget.items.description,
                  style: const TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  right: 8.0,
                ),
                child: ElevatedButton.icon(
                    onPressed: () {
                      //addToCart(widget.items);
                      ref
                          .read(shoppingCartProvider.notifier)
                          .addToCart(widget.items);
                      ScaffoldMessenger.of(context).showSnackBar(
                        mySnackBar("${widget.items.title} added to Cart!"),
                      );
                    },
                    icon: Icon(
                      Icons.add_shopping_cart,
                      size: 15,
                      color: Colors.grey[700],
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green[300],
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
  }
}
