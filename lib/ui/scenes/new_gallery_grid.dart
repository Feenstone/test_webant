import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_strings.dart';
import 'package:test_webant/ui/custom_widgets/no_internet_connection_widget.dart';
import 'package:test_webant/models/photo_entity.dart';
import 'package:http/http.dart' as http;
import 'package:test_webant/ui/custom_widgets/custom_gridview.dart';
import 'package:test_webant/resources/app_colors.dart';

class NewGalleryGrid extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _NewGalleryGridState();
  }
}

class _NewGalleryGridState extends State<NewGalleryGrid> {

  List<Photo> data = new List<Photo>();

  ScrollController _scrollController = new ScrollController();

  StreamController<List<Photo>> _photosStreamController = StreamController<
      List<Photo>>.broadcast();

  bool _isLoading = false;

  int page = 1;

  int maxPage;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<
      RefreshIndicatorState>();

  Future<List<Photo>> _fetchPhotos() async {
    try {
      final response = await http.get(
          AppStrings().newGalleryUrl + page.toString() + AppStrings().limit);
      Map<String, dynamic> decodedJson = json.decode(response.body);
      maxPage = decodedJson['countOfPages'] as int;
      List photos = decodedJson['data'] as List;
      List<Photo> result = (photos.map((photo) => Photo.fromJson(photo))).toList();
      data.addAll(result);
      _photosStreamController.sink.add(data);
    }
    catch(e) {
      _photosStreamController.sink.addError(e);
    }
    finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    data.clear();
    page = 1;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        setState(() {
          _isLoading = true;
        });
        _fetchPhotos();
      }
    });
    _photosStreamController.onListen = _fetchPhotos;
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _refreshIndicatorKey.currentState.show());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings().newGalleryGridTitle,
          style: TextStyle(color: AppColors.titleColor,)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
          body: StreamBuilder<List<Photo>>(
            stream: _photosStreamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return NoInternetConnection().noInternetConnection();
                  }
                  else if (snapshot.hasData || data.isNotEmpty) {
                    return Column(
                        children: <Widget> [
                          Flexible(
                            fit: FlexFit.loose,
                            child: RefreshIndicator(
                              key: _refreshIndicatorKey,
                              onRefresh: _refresh,
                              child: CustomGridView().photoGridView(snapshot.data ?? data, _scrollController),
                            ),
                          ),
                          Visibility(
                            visible: _isLoading&&page<maxPage,
                            child: Center(
                              child: LinearProgressIndicator(),
                              ),
                            ),
                          ],
                    );
                  }
              }
              return null;
            }
              ),
          );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      data.clear();
      page = 1;
      _fetchPhotos();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _photosStreamController?.close();
  }
}