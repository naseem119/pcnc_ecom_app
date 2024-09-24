import 'package:flutter/material.dart';

class NoResultsFoundWidget extends StatelessWidget {
  const NoResultsFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/not_found.png',
            width: 128,
            height: 128,
          ),
          const SizedBox(height: 20),
          const Text(
            'Oops!!!\nNO results found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16, // adjust font size
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
