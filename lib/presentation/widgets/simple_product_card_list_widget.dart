import 'package:flutter/material.dart';
import 'package:pcnc_ecom_app/presentation/widgets/simple_product_card_widget.dart';
import '../../data/models/product_model.dart';

class SimpleProductCardListWidget extends StatelessWidget {
  final Future<List<Product>> products;

  SimpleProductCardListWidget({required this.products});

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
          return Container(
            height: 186,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SimpleProductCardWidget(
                    product: snapshot.data![index],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
