import 'package:dartz/dartz.dart';
import 'package:test_webant/core/errors/failures.dart';
import 'package:test_webant/features/gallery/data/models/photo_model.dart';
import 'package:test_webant/features/gallery/domain/entities/photo.dart';

abstract class WebantGalleryRepository {
  Future<Either<Failure, List<Photo>>> getNewPhotos(int page);
  Future<Either<Failure, List<Photo>>> getPopularPhotos(int page);
  Future<Either<Failure, Photo>> getSinglePhoto(int imageId);
}