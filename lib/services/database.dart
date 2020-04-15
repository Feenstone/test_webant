import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_webant/models/photo_entity.dart';

class DatabaseService{

  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference photoCollection = Firestore.instance.collection('photos');

  Future createUserData(String name, String email, String password, String uid) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future createPhotoData(String name, String description, String url, String uploadDateTime) async {
    return await photoCollection.document(name).setData({
      'name': name,
      'description': description,
      'url': url,
      'type': 'new',
      'watchCount': 0,
      'uploadDate': uploadDateTime
    });
  }

  List<Photo> _photoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Photo(
        name: doc.data['name'],
        description: doc.data['description'],
        type: doc.data['type'],
        url: doc.data['url'],
        watchCount: doc.data['watchCount'],
        uploadDate: doc.data['uploadDate'],
      );
    }).toList();
  }

  Stream<List<Photo>> get photos {
    return photoCollection.snapshots().map(_photoListFromSnapshot);
  }
}