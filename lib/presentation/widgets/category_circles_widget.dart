import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../views/category_products_screen.dart';

class CategoryCirclesWidget extends StatelessWidget {
  final CategoryController categoryController;

  CategoryCirclesWidget({required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (categoryController.categories.isEmpty) {
        return Center(child: Text('No categories available.'));
      } else {
        final randomCategories = categoryController.categories.toList()
          ..shuffle();
        final displayedCategories = randomCategories.take(10).toList();

        return Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayedCategories.length,
            itemBuilder: (context, index) {
              final category = displayedCategories[index];
              final imageUrl =
                  category.imageUrl.isNotEmpty ? category.imageUrl : '';

              return GestureDetector(
                onTap: () {
                  Get.to(() => CategoryProductsScreen(
                        categoryId: category.id,
                        categoryName: category.name,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey[200],
                        child: ClipOval(
                          child: imageUrl.isNotEmpty
                              ? Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  width: 56,
                                  height: 56,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    // fallback icon when the image fails to load
                                    return Image.asset(
                                      'assets/images/img_not_available.png',
                                      fit: BoxFit.cover,
                                      width: 56,
                                      height: 56,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/img_not_available.png',
                                  fit: BoxFit.cover,
                                  width: 56,
                                  height: 56,
                                ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }
}
