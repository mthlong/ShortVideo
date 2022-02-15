import 'package:final_app/app/constants/app_colors.dart';
import 'package:final_app/app/ui/pages/add_video_page.dart';
import 'package:final_app/app/ui/pages/discover_page.dart';
import 'package:final_app/app/ui/pages/home_page.dart';
import 'package:final_app/app/ui/pages/inbox_page.dart';
import 'package:final_app/app/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'widget/custom_bottom_navigation_bar.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({Key? key}) : super(key: key);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  int _selectedPageIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    DiscoverPage(),
    InboxPage(),
    ProfilePage()
  ];

  void _onIconTapper(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedPageIndex: _selectedPageIndex, onIconTap: _onIconTapper),
    );
  }
}
