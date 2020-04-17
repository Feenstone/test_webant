import 'package:flutter/material.dart';
import 'package:test_webant/ui/custom_widgets/custom_app_bar.dart';
import 'package:test_webant/ui/custom_widgets/gallery_grid.dart';

class SplitGalleryScreen extends StatefulWidget {
  @override
  _SplitGalleryScreenState createState() => _SplitGalleryScreenState();
}

class _SplitGalleryScreenState extends State<SplitGalleryScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _tabController = new TabController(length: 2,vsync: this);
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
      appBar: GalleryAppBar(_tabController),
        body: TabBarView(
          controller: _tabController,
          children: [
            GalleryGrid("new"),
            GalleryGrid("popular"),
          ],
        ),
    );
  }
}
