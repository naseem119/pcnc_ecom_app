import 'package:flutter/material.dart';
import 'package:pcnc_ecom_app/presentation/widgets/shared_widgets/no_results_found_widget.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/ecommerce_repository.dart';
import '../widgets/card_widgets/product_card_widget.dart';

class CategoryProductsScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  CategoryProductsScreen(
      {required this.categoryId, required this.categoryName});

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
        title: Text(
          categoryName,
          style: TextStyle(
            fontFamily: 'Libre',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFFF2673B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFF9F9F9),
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Product>>(
        future: EcommerceRepository.getProductsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading products'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return NoResultsFoundWidget();
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // display 2 products per row
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio:
                    0.75, // adjust the height-to-width ratio of the product cards
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ProductCardWidget(
                    product:
                        product); // using the ProductCardWidget to display each product
              },
            );
          }
        },
      ),
    );
  }
}
