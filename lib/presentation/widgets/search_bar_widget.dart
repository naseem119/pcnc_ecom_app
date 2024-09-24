import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to the SearchScreen when the search bar is tapped
        Get.to(() => SearchScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
        child: TextField(
          enabled: false, // disable direct typing to make it navigational
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
        ),
      ),
    );
  }
}
