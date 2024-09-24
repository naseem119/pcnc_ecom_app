import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrendingProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFF2673A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Trending Products',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg'),
                      const SizedBox(width: 8),
                      const Text('Last Date 29/02/22',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  visualDensity: VisualDensity.compact, // reduces the height of the button
                  side: BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // rounded corners
                  ),
                  backgroundColor: Colors.transparent, // transparent background
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Not functional yet'),
                    duration: Duration(milliseconds: 300),
                  ));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8), // space between text and arrow
                    SvgPicture.asset('assets/icons/forward_arrow.svg'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
