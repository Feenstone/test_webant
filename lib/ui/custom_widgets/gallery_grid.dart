import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/custom_widgets/no_internet_connection_widget.dart';
import 'package:test_webant/ui/custom_widgets/no_photos_screen.dart';
import 'package:test_webant/ui/custom_widgets/photo_gridview.dart';
import 'package:test_webant/bloc/photo_bloc.dart';

class GalleryGrid extends StatefulWidget {
  final String galleryType;

  GalleryGrid(this.galleryType);

  @override
  State<StatefulWidget> createState() {
    return _GalleryGridState();
  }
}

class _GalleryGridState extends State<GalleryGrid> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  var photoBloc = PhotoBloc();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    photoBloc.fetchFirstList(widget.galleryType);

    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<List<DocumentSnapshot>>(
          stream: photoBloc.photoStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return NoInternetConnectionWidget();
            } else if (snapshot.data?.length == 0) {
              return NoPhotosScreen();
            } else if (snapshot?.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.formFieldColor),
                    ),
                    Text(AppStrings().preloaderText),
                  ],
                ),
              );
            } else if (snapshot.data.length > 0) {
              return Column(
                children: <Widget>[
                  RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async => photoBloc.documentListClear(widget.galleryType),
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: PhotoGridView(snapshot.data, _controller),
                    ),
                  ),
                ],
              );
            }
            return null;
          },
        ));
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      photoBloc.fetchNextPhotos(widget.galleryType);
    }
  }
}
