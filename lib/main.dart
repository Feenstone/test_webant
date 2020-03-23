import 'package:flutter/material.dart';
import 'package:test_webant/galleryGrid.dart';
import 'package:test_webant/PopularGalleryGrid.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: DashboardScreen(title: 'Gallery'),
      );
    }
}

class DashboardScreen extends StatefulWidget{
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;

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
          NewGalleryGrid(),
          PopularGalleryGrid(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFFFFFFFF),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases),
              title: Text('New',
              style: TextStyle(
                color: Color(0xFF8C8C8C)
              ),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Popular',
              style: TextStyle(
                color: Color(0xFF8C8C8C)
              ),),
            ),
          ],
          selectedItemColor: Color(0xFFED5992),
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}