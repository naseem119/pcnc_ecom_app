import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';

class SimpleProductCardWidget extends StatelessWidget {
  final Product product;

  SimpleProductCardWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    // get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.35, // image 35% of the screen width
      height: screenWidth * 0.5,  // image 0.
      child: LayoutBuilder(
        builder: (context, constraints) {
          // the total height of the card is constraints.maxHeight
          double cardHeight = constraints.maxHeight;
          double imageHeight = cardHeight * 0.5; // reduced image height to 50% of the card's height

          return Card(
            color: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // gestureDetector to handle image tap
                GestureDetector(
                  onTap: () {
                    // show full image in a popup
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(); // close the dialog when tapped
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  // fallback image in case the network image fails
                                  return Image.asset(
                                    'assets/images/img_not_available.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(6.0), bottom: Radius.circular(4.0)),
                    child: Image.network(
                      product.imageUrl,
                      height: imageHeight, // set the height to 50% of the card
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        // fallback image in case the network image fails
                        return Image.asset(
                          'assets/images/img_not_available.png',
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                // padding around the text details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // product title with bold style and max 3 lines
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          maxLines: 3, // limit to 3 lines
                          overflow: TextOverflow.ellipsis, // add ellipsis if it exceeds 3 lines
                        ),
                        Spacer(), // push the price to the bottom
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
