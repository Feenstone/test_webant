import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_webant/services/database.dart';

class UserPhotoBloc{
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> userPhotoController;

  UserPhotoBloc() {
  userPhotoController = BehaviorSubject<List<DocumentSnapshot>>();
  }

  Stream<List<DocumentSnapshot>> get userPhotoStream => userPhotoController.stream;

  Future getUserPhotos(data) async{
    try {
      documentList = (await DatabaseService()
          .photoCollection
          .where("author", isEqualTo: data['email'])
          .getDocuments())
          .documents;
      userPhotoController.sink.add(documentList);
    }
    catch (e) {
      print(e.toString());
    }
  }
}
