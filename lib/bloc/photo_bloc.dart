import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
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
      photoController.sink.addError(SocketException("No internet connection"));
    } catch (e) {
      print(e.toString());
      photoController.sink.addError(e);
    }
  }

  void documentListClear(String type) async {
    documentList.clear();
    fetchFirstList(type);
  }

  void dispose() {
    photoController.close();
  }
}
