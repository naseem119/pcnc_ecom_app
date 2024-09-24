import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import '../card_widgets/product_card_widget.dart';

class RandomProductsGridWidget extends StatelessWidget {
  final Future<List<Product>> products;

  RandomProductsGridWidget({required this.products});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading products'));
        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return ProductCardWidget(product: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
