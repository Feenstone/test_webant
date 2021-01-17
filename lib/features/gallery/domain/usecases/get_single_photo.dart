import 'package:dartz/dartz.dart';
import 'package:test_webant/core/errors/failures.dart';
import 'package:test_webant/core/usecases/usecase.dart';
import 'package:test_webant/features/gallery/domain/entities/photo.dart';
import 'package:test_webant/features/gallery/domain/repositories/webant_gallery_repository.dart';

class GetSinglePhoto implements UseCase<Photo, ImageIdParams> {
  final WebantGalleryRepository repository;

  GetSinglePhoto(this.repository);

  @override
  Future<Either<Failure, Photo>> call(ImageIdParams params) async {
    return await repository.getSinglePhoto(params.imageId);
  }
}