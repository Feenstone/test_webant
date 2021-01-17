import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:test_webant/core/errors/failures.dart';
import 'package:test_webant/features/gallery/domain/entities/photo.dart';
import 'package:test_webant/features/gallery/domain/repositories/webant_gallery_repository.dart';
import 'package:test_webant/features/gallery/presentation/state_notifier/photos_state.dart';

typedef Future<Either<Failure, List<Photo>>> _NewOrPopularChooser(int page);

class PhotosNotifier extends StateNotifier<PhotosState> {
  final WebantGalleryRepository _webantRepository;

  final _NewOrPopularChooser _newOrPopularChooser;

  PhotosNotifier(this._webantRepository, this._newOrPopularChooser)
      : super(PhotosState.initial()) {
    getPhotos();
  }

  Future<void> getPhotos() async {
    final photos = await _newOrPopularChooser(state.page);
    photos.fold(
        (l) => state = state.copyWith(errorMessage: l.toString(), error: true),
        (photos) {
      state = state.copyWith(photos: [...state.photos, ...photos], error: false);
    });
  }

  Future<void> getNextPage() async {
    state = state.copyWith(nextPhotoLoading: true);
    state = state.copyWith(page: state.page + 1);
    getPhotos();
    state = state.copyWith(nextPhotoLoading: false);
  }
}
