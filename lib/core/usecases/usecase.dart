import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_webant/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

abstract class Params {}

class PageParams extends Params{
  final int page;

  PageParams({@required this.page});
}

class ImageIdParams extends Params{
  final int imageId;

  ImageIdParams({@required this.imageId});
}