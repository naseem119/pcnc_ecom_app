import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;

  ProductCardWidget({required this.product});

  void showMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Not functional yet'), duration: Duration(milliseconds: 300)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image Section with GestureDetector
            Flexible(
              flex: 1,
              child: GestureDetector(
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
                  borderRadius: BorderRadius.circular(4.0), // adjust the radius as needed
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
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
            ),
            SizedBox(height: 8),

            // 2. Title Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4),

            // 3. Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.description,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4),

            // 4. Price Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),

            // 5. Button Section with spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), // Added padding around the buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // left-aligned Favorite and Bookmark buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0), // Add space between buttons
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                              'assets/icons/favourite.svg',
                              width: 20,
                              height: 20,
                            ),
                            onPressed: () => showMessage(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0), // add space between buttons
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: ImageIcon(
                              AssetImage('assets/icons/bookmark.png'), // path to your PNG icon
                              size: 20, // size of the icon (optional)
                              color: Colors.black, // icon color (optional)
                            ),
                            onPressed: () => showMessage(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Right-aligned Shopping Cart button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0), // Add space around Shopping Cart button
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/add_to_shopppping_cart.svg',
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () => showMessage(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
