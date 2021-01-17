import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:test_webant/features/gallery/domain/entities/photo.dart';
import 'package:test_webant/features/gallery/presentation/pages/single_image.dart';

import '../../../../providers.dart';

typedef Future<void> _Callback();
class GalleryGrid extends StatefulWidget {
  final List<Photo> photos;
  final String title;
  final _Callback onRefreshCallback;
  final _Callback endOfTheScreenCallback;

  GalleryGrid(
      {Key key,
        @required this.photos,
        @required this.title,
        @required this.onRefreshCallback,
        @required this.endOfTheScreenCallback})
      : super(key: key);

  @override
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  final _scrollController = new ScrollController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.endOfTheScreenCallback();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: TextStyle(
                color: Color(0xFF2F1767),
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async => widget.onRefreshCallback(),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return Card(
                                semanticContainer: true,
                                elevation: 5.7,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    child: Image.network(
                                      'http://gallery.dev.webant.ru/media/' +
                                          widget.photos[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () async {
                                      _navigateToImage(
                                          context, widget.photos[index]);
                                    }),
                              );
                            },
                            childCount: widget.photos.length,
                          ),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 180 / 128,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          )),
                      SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}

void _navigateToImage(BuildContext context, Photo photo) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => SingleImage(photo: photo),
    ),
  );
}
