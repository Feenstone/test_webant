import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:test_webant/data/photoEntity.dart';
import 'package:http/http.dart' as http;
import 'package:test_webant/data/SingleImage.dart';
import 'package:test_webant/UI/commonUi.dart';
import 'package:cached_network_image/cached_network_image.dart';

final galleryUrl = "http://gallery.dev.webant.ru/api/photos?popular=true&page=";

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
    setState(() {
      _isLoading = true;
    });
    try {
      developer.log('fetch photos');
      final response = await http.get(
          galleryUrl + page.toString() + "&limit=10");
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
    _fetchPhotos();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        developer.log('scroll controller');
          page++;
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
          style: TextStyle(color: Color(0xFF2F1767),)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
          body: StreamBuilder<List<Photo>>(
            stream: _photosStreamController.stream,
            builder:(context, snapshot){
              developer.log('builder');
              if (snapshot.hasData || data.isNotEmpty){
                return Column(
                  children: <Widget> [
                    Flexible(
                      fit: FlexFit.loose,
                      child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: _refresh,
                        child: _photoGridView(snapshot.data ?? data),
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
                return CommonUI.noInternetConnection();
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

  GridView _photoGridView(data){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 180/128,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: data.length,
      itemBuilder: (context, index){
        return Card(
            semanticContainer: true,
          elevation: 5.7,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(8.0),
            child:GestureDetector(
              child: CachedNetworkImage(
            imageUrl: ('http://gallery.dev.webant.ru/media/' + data[index].image),
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
              onTap: () => _navigateToImage(context, data[index].id),
            ),
        );
      },
      controller: _scrollController,
    );
  }

  void _navigateToImage(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SingleImage(imageId: id),
      ),
    );
  }

}