import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:test_webant/generator/list_data_source.dart';
import 'package:test_webant/models/photo_entity.dart';

class PhotoBloc {

  PhotoBloc([this.url]);

  bool isLoading;
  int _page = 1;
  final _photo = ListDataSource();
  final _photoFetcher = PublishSubject<List<Photo>>();
  List<Photo> photolist = new List<Photo>();
  String url;

  Stream<List<Photo>> get allPhotos => _photoFetcher.stream;

  fetchAllPhotos() async {
    List<Photo> templist = await _photo.fetchPhotos(_page, url);
    photolist.addAll(templist);
    _photoFetcher.sink.add(photolist);
    _page++;
    isLoading = false;
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _photoFetcher.add(null);
    _page = 1;
    fetchAllPhotos();
  }

  void dispose() {
    _photoFetcher.close();
  }
}
