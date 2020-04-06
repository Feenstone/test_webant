import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/Resources/AppColors/app_colors.dart';
import 'package:test_webant/Resources/AppStrings/app_strings.dart';
import 'package:test_webant/Ui/CustomWidgets/no_internet_connection_widget.dart';
import 'package:test_webant/models/photo_entity.dart';
import 'package:http/http.dart' as http;
import 'package:test_webant/Ui/CustomWidgets/custom_gridview.dart';

int page = 1;

int maxPage;

class PopularGalleryGrid extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _PopularGalleryGridState();
  }
}

class _PopularGalleryGridState extends State<PopularGalleryGrid>{

  bool _isLoading = false;

  List<Photo> data = new List<Photo>();

  ScrollController _scrollController = new ScrollController();

  StreamController<List<Photo>> _photosStreamController = StreamController<List<Photo>>.broadcast();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Future<List<Photo>> _fetchPhotos() async {
    try {
      final response = await http.get(
          AppStrings().popularGalleryUrl + page.toString() + "&limit=10");
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
  void initState(){
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular',
          style: TextStyle(color: AppColors.titleColor,)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
          body: StreamBuilder<List<Photo>>(
            stream: _photosStreamController.stream,
            builder:(context, snapshot){
              if (snapshot.hasData || data.isNotEmpty){
                return Column(
                  children: <Widget> [
                    Flexible(
                      fit: FlexFit.loose,
                      child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: _refresh,
                        child: CustomGridView().photoGridView(snapshot.data ?? data,_scrollController),
                      ),
                    ),
                    Visibility(
                      visible: _isLoading&&page<maxPage,
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    )
                  ],
                );
              }
              else if (snapshot.hasError) {
                return NoInternetConnection().noInternetConnection();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
      );
  }

  Future<Null> _refresh() async{
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