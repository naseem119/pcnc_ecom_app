import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../controllers/category_controller.dart';
import '../controllers/product_controllers.dart';
import '../widgets/category_card.dart';
import '../widgets/simple_product_card_widget.dart';
import '../widgets/no_results_found_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final CategoryController categoryController = Get.find();
  final ProductController productController = Get.find();
  String searchQuery = ''; // to store the search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Search',
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
      backgroundColor: Color(0xFFF9F9F9), // set background color of the screen
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // search bar at the top
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
                child: TextField(
                  autofocus: true, // the search bar will be active immediately
                  decoration: InputDecoration(
                    hintText: 'Search any Product',
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
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value
                          .toLowerCase(); // convert search query to lowercase
                    });
                  },
                ),
              ),

              // the filtered products and categories will be displayed here
              Expanded(
                child: Obx(() {
                  if (categoryController.isLoading.value ||
                      productController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // filtering categories and products based on the search query
                  final filteredCategories =
                      categoryController.categories.where((category) {
                    return category.name.toLowerCase().contains(searchQuery);
                  }).toList();

                  final filteredProducts =
                      productController.products.where((product) {
                    return product.title.toLowerCase().contains(searchQuery) ||
                        product.description.toLowerCase().contains(searchQuery);
                  }).toList();

                  // if no categories and no products match the search query, show NoResultsFoundWidget
                  if (filteredCategories.isEmpty && filteredProducts.isEmpty) {
                    return NoResultsFoundWidget();
                  }

                  // if categories or products exist, display the results
                  return _buildResults(filteredCategories, filteredProducts);
                }),
              ),
            ],
          )),
    );
  }

  // helper method to display two sections: categories and products, each scrollable horizontally
  Widget _buildResults(List<Category> categories, List<Product> products) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // section 1: Categories (only show if there are matching categories)
          if (categories.isNotEmpty) ...[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150, // adjust height as per your CategoryCard design
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CategoryCard(category: category),
                  );
                },
              ),
            ),
          ],

          // section 2: Products (only show if there are matching products)
          if (products.isNotEmpty) ...[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 186,
              // adjust height based on the SimpleProductCardWidget design
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SimpleProductCardWidget(product: product),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
