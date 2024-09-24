import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecom_app/presentation/controllers/product_controllers.dart';
import '../../../data/models/product_model.dart';
import '../../../services/api_service.dart';
import '../../controllers/category_controller.dart';
import '../card_widgets/category_circles_widget.dart';
import '../dashboard_widgets/category_section_widget.dart';
import '../dashboard_widgets/random_products_grid_widget.dart';
import '../dashboard_widgets/search_bar_widget.dart';
import '../dashboard_widgets/simple_product_card_list_widget.dart';
import '../dashboard_widgets/trending_products_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Future<List<Product>> products;
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    products = ApiService.getProducts(limit: 10);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            SearchBarWidget(),

            // Categories Section
            CategorySectionWidget(),
            SizedBox(height: 16),

            // Category Circles Section
            CategoryCirclesWidget(categoryController: categoryController),
            SizedBox(height: 16),

            // Random Products Section
            RandomProductsGridWidget(products: products),
            SizedBox(height: 16),

            // Trending Products Section
            TrendingProductsWidget(),
            SizedBox(height: 16),

            // Simple Product Cards Section
            SimpleProductCardListWidget(products: products),
          ],
        ),
      ),
    );
  }
}
