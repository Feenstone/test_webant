import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_webant/models/photo_entity.dart';
import 'package:test_webant/services/database.dart';

class PhotoBloc {
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> photoController;

  PhotoBloc() {
    photoController = BehaviorSubject<List<DocumentSnapshot>>();
  }

  Stream<List<DocumentSnapshot>> get photoStream => photoController.stream;

  Future fetchFirstList(String type) async {
    try {
      documentList = (await DatabaseService()
              .photoCollection
              .where("type", isEqualTo: type)
              .limit(10)
              .getDocuments())
          .documents;
      photoController.sink.add(documentList);
    } on SocketException {
      photoController.sink.addError(SocketException("No internetConnection"));
    } catch (e) {
      print(e.toString());
      photoController.sink.addError(e);
    }
  }

  fetchNextPhotos(String type) async {
    try {
      documentList = (await DatabaseService()
              .photoCollection
              .where("type", isEqualTo: type)
              .startAfterDocument(documentList[documentList.length - 1])
              .limit(10)
              .getDocuments())
          .documents;
      photoController.sink.add(documentList);
    } on SocketException {
      photoController.sink.addError(SocketException("No internetConnection"));
    } catch (e) {
      print(e.toString());
      photoController.sink.addError(e);
    }
  }

  void dispose() {
    photoController.close();
  }
}
//
//  bool isLoading;
//  int _page = 1;
//  final _photo = ListDataSource();
//  final _photoFetcher = PublishSubject<List<Photo>>();
//  List<Photo> photolist = new List<Photo>();
//  String url;
//
//  Stream<List<Photo>> get allPhotos => _photoFetcher.stream;
//
//  fetchAllPhotos() async {
//    List<Photo> templist = await _photo.fetchPhotos(_page, url);
//    photolist.addAll(templist);
//    _photoFetcher.sink.add(photolist);
//    _page++;
//    isLoading = false;
//  }
//
//  Future<void> refresh() async {
//    await Future.delayed(Duration(milliseconds: 1000));
//    photolist.clear();
//    _page = 1;
//    fetchAllPhotos();
//  }
//
//  void dispose() {
//    _photoFetcher.close();
//  }
//}
