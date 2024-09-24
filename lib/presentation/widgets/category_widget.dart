import 'package:flutter/material.dart';

import '../../data/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  CategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(category.imageUrl),
          radius: 30,
        ),
        SizedBox(height: 8),
        Text(category.name, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
