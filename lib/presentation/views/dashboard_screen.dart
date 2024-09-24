import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcnc_ecom_app/presentation/widgets/no_results_found_widget.dart';
import '../controllers/auth_controller.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/floating_cart_button_widget.dart';
import '../widgets/home_widget.dart';
import 'search_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthController authController = Get.put(AuthController());
  int _selectedIndex = 0; // default selected index is Home (0)

  void _onItemTapped(int index) {
    if (index == 2) {
      // do not change index for shopping cart button
      return;
    }

    if (index == 3) {
      // navigate to the search screen if search is selected
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchScreen()), // Push to SearchScreen
      );
      return; // do not update the _selectedIndex as we're navigating to another screen
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Prevent closing the app when back button is pressed
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          appBar: const AppBarWidget(),
          drawer: DrawerWidget(),
          body: Column(
            children: [
              Expanded(
                child: _selectedIndex == 0 // home screen
                    ? HomeWidget()
                    : Center(
                        // ensure NoResultsFoundWidget is centered
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NoResultsFoundWidget(),
                          ],
                        ),
                      ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBarWidget(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          floatingActionButton: const FloatingCartButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }
}
