import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:test_webant/features/gallery/presentation/pages/gallery_grid.dart';
import 'package:test_webant/features/gallery/presentation/widgets/common_ui.dart';
import 'package:test_webant/providers.dart';

class MainScreen extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final controllerPage = useState(0);
    final pageController = usePageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        children: [
          Consumer(builder: (context, watch, child) {
            final state = watch(newPhotosNotifierProvider.state);
            if (state.error == true) {
              return NoInternetConnection();
            }
            if (state.photos.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GalleryGrid(
                photos: state.photos,
                title: 'New',
                onRefreshCallback: () =>
                    context.refresh(newPhotosNotifierProvider).getPhotos(),
                endOfTheScreenCallback: () =>
                    context.read(newPhotosNotifierProvider).getNextPage(),
              );
            }
          }),
          Consumer(builder: (context, watch, child) {
            final state = watch(popularPhotosNotifierProvider.state);
            if (state.error == true) {
              return NoInternetConnection();
            } else if (state.photos.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GalleryGrid(
                photos: state.photos,
                title: 'Popular',
                onRefreshCallback: () =>
                    context.refresh(popularPhotosNotifierProvider).getPhotos(),
                endOfTheScreenCallback: () =>
                    context.read(popularPhotosNotifierProvider).getNextPage(),
              );
            }
          }),
        ],
        onPageChanged: (page) {
          controllerPage.value = page;
        },
        controller: pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFFFFFFFF),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.new_releases), label: 'New'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Popular'),
          ],
          selectedItemColor: Color(0xFFED5992),
          onTap: (page) {
            pageController.animateToPage(page,
                duration: const Duration(microseconds: 300),
                curve: Curves.ease);
          },
          currentIndex: controllerPage.value,
        ),
      ),
    );
  }
}
