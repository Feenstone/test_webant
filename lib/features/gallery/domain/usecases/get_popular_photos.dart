import 'package:dartz/dartz.dart';
import 'package:test_webant/core/errors/failures.dart';
import 'package:test_webant/core/usecases/usecase.dart';
import 'package:test_webant/features/gallery/domain/entities/photo.dart';
import 'package:test_webant/features/gallery/domain/repositories/webant_gallery_repository.dart';

class GetPopularPhotos implements UseCase<List<Photo>, PageParams> {
  final WebantGalleryRepository repository;

  GetPopularPhotos(this.repository);

  @override
  Future<Either<Failure, List<Photo>>> call(PageParams params) async {
    return await repository.getPopularPhotos(params.page);
  }
}