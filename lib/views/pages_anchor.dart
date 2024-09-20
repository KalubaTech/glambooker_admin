import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:glambooker_admin/utils/colors.dart';
import 'package:glambooker_admin/views/home/dashboard.dart';
import 'package:glambooker_admin/views/services/bookings.dart';
import 'package:glambooker_admin/views/services/search_services.dart';
import 'package:glambooker_admin/views/user/profile.dart';

class PagesAnchor extends StatefulWidget {
  const PagesAnchor({super.key});

  @override
  State<PagesAnchor> createState() => _PagesAnchorState();
}

class _PagesAnchorState extends State<PagesAnchor> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,  // Link the PageController to the PageView
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;  // Update the current index
          });
        },
        children: [
          Dashboard(),
          SearchServices(),
          Bookings(),
          Profile(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: FluidNavBar(
        style: FluidNavBarStyle(
          barBackgroundColor: Karas.primary,
        ),
        icons: [
          FluidNavBarIcon(icon: Icons.home, selectedForegroundColor: Colors.white),
          FluidNavBarIcon(icon: Icons.search, selectedForegroundColor: Colors.white),
          FluidNavBarIcon(icon: Icons.shopping_bag, selectedForegroundColor: Colors.white),
          FluidNavBarIcon(icon: Icons.person, selectedForegroundColor:  Colors.white),
        ],
        onChange: (int index) {
          setState(() {
            _currentIndex = index;  // Update the index
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
        defaultIndex: _currentIndex,  // Set the default index
      ),
    );
  }
}
