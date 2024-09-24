import 'package:flutter/material.dart';

class FloatingCartButtonWidget extends StatelessWidget {
  const FloatingCartButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Not functional yet'),
              duration: Duration(milliseconds: 300),
            ));
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          shape: const CircleBorder(),
          elevation: 0,
        ),
      ),
    );
  }
}
