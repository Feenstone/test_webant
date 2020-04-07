import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/ui/scenes/popular_gallery_grid.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: DashboardScreen(),
      );
    }
}

class DashboardScreen extends StatefulWidget{
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(microseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: [
            GalleryGrid(AppStrings().newGalleryUrl, AppStrings().popularGalleryGridTitle),
            GalleryGrid(AppStrings().popularGalleryUrl,AppStrings().popularGalleryGridTitle),
          ],
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              title: Text(AppStrings.firstBottomNavigationBarItemTitle,
              style: TextStyle(
                color: AppColors.bottomNavBarTextColor
              ),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text(AppStrings.secondBottomNavigationBarItemTitle,
              style: TextStyle(
                color: AppColors.bottomNavBarTextColor
              ),),
            ),
          ],
          selectedItemColor: AppColors.activeBottomNavBarIconColor,
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}