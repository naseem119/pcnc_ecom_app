import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/category_model.dart';
import '../views/category_products_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // navigate to CategoryProductsScreen when the card is tapped
        Get.to(() => CategoryProductsScreen(
          categoryId: category.id, // pass the category ID
          categoryName: category.name, // pass the category name for the app bar title
        ));
      },
      child: SizedBox(
        width: screenWidth * 0.35,
        height: screenWidth * 0.5,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double cardHeight = constraints.maxHeight;
            double imageHeight = cardHeight * 0.5;

            return Card(
              color: Colors.white,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(6.0), bottom: Radius.circular(4.0)),
                    child: Image.network(
                      category.imageUrl,
                      height: imageHeight,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
