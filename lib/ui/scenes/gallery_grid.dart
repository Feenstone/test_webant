import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/custom_widgets/no_internet_connection_widget.dart';
import 'package:test_webant/models/photo_entity.dart';
import 'package:test_webant/ui/custom_widgets/photo_gridview.dart';
import 'package:test_webant/bloc/photo_bloc.dart';

class GalleryGrid extends StatefulWidget {

 final String url;
 final String title;

  GalleryGrid(this.url,this.title);

  @override
  State<StatefulWidget> createState() {
    return _GalleryGridState();
  }
}

class _GalleryGridState extends State<GalleryGrid> {
  ScrollController _scrollController = new ScrollController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var _bloc;

  @override
  void initState() {
    PhotoBloc().refresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.fetchAllPhotos();
      }
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = PhotoBloc(widget.url);
    _bloc.fetchAllPhotos();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: TextStyle(
                color: AppColors.titleColor,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<List<Photo>>(
          stream: _bloc.allPhotos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () => _bloc.refresh(),
                      child: PhotoGridView(snapshot.data, _scrollController),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return NoInternetConnectionWidget();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
