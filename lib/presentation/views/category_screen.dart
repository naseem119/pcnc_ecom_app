import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/no_results_found_widget.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController categoryController = Get.find();
  String searchQuery = ''; // search query to filter categories

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            fontFamily: 'Libre',
            color: Color(0xFFF2673B),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF9F9F9),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // apply 16 padding around all edges
        child: Column(
          children: [
            // Search bar section
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // bottom padding for the search bar
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search any Category',
                  hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.search, color: Color(0xFFBBBBBB)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase(); // update the search query and convert to lowercase
                  });
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (categoryController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (categoryController.categories.isEmpty) {
                  return Center(child: Text('No categories available.'));
                } else {
                  // filter the categories based on the search query
                  final filteredCategories = categoryController.categories.where((category) {
                    return category.name.toLowerCase().contains(searchQuery);
                  }).toList();

                  if (filteredCategories.isEmpty) {
                    return NoResultsFoundWidget();
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // minimum of 2 items in a row
                      crossAxisSpacing: 16.0, // horizontal spacing between cards
                      mainAxisSpacing: 16.0, // vertical spacing between cards
                      childAspectRatio: 0.75, // aspect ratio for the CategoryCard (width/height ratio)
                    ),
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return CategoryCard(
                        category: category, // use the modified CategoryCard
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
