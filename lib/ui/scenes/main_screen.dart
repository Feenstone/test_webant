import 'package:flutter/material.dart';
import 'package:test_webant/ui/scenes/create_photo_screen.dart';
import 'package:test_webant/ui/scenes/split_gallery_screen.dart';
import 'package:test_webant/ui/scenes/user_info_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _galleryWidgets = <Widget>[
    SplitGalleryScreen(),
    CreatePhotoScreen(),
    UserInfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _galleryWidgets.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFC4C4C4))
          )
        ),
        height: 55,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(''),
            ),
          ],
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          unselectedItemColor: Color(0xFFDADADA),
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
        ),
      ),
    );
  }
}
