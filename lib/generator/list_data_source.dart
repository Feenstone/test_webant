import 'package:test_webant/bloc/photo_bloc.dart';
import 'package:test_webant/models/photo_entity.dart';
import 'package:http/http.dart' as http;
import 'package:test_webant/resources/app_strings.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class ListDataSource {

  Future<List<Photo>> fetchPhotos(int page, String url) async {
      developer.log('ya eblan');
      final response = await http.get(
      url + page.toString() + AppStrings().limit);
      Map<String, dynamic> decodedJson = json.decode(response.body);
      List photos = decodedJson['data'] as List;
      List<Photo> result = (photos.map((photo) => Photo.fromJson(photo))).toList();
      return result;
  }
}