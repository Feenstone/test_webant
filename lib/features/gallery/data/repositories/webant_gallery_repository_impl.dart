import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_webant/core/errors/exceptions.dart';
import 'package:test_webant/core/errors/failures.dart';
import 'package:test_webant/core/network/network_info.dart';
import 'package:test_webant/features/gallery/data/datasources/webant_gallery_remote_datasource.dart';
import 'package:test_webant/features/gallery/domain/entities/photo.dart';
import 'package:test_webant/features/gallery/domain/repositories/webant_gallery_repository.dart';

typedef Future<List<Photo>> _NewOrPopularChooser();

class WebantGalleryRepositoryImpl implements WebantGalleryRepository {
  final WebantGalleryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WebantGalleryRepositoryImpl({@required this.remoteDataSource,@required this.networkInfo});

  @override
  Future<Either<Failure, List<Photo>>> getNewPhotos(int page) async {
    return await _getPhotos(() {
      return remoteDataSource.getNewPhotos(page);
    });
  }

  @override
  Future<Either<Failure, List<Photo>>> getPopularPhotos(int page) async {
    return await _getPhotos(() {
      return remoteDataSource.getPopularPhotos(page);
    });
  }

  @override
  Future<Either<Failure, Photo>> getSinglePhoto(int imageId) async {
    if(await networkInfo.isConnected){
      try{
        final remotePhoto = await remoteDataSource.getSinglePhoto(imageId);
        return Right(remotePhoto);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Photo>>> _getPhotos(_NewOrPopularChooser getNewOrPopular) async {
    if(await networkInfo.isConnected) {
      try{
        final remotePhotos = await getNewOrPopular();
        return Right(remotePhotos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}