import 'package:test_webant/features/gallery/domain/entities/photo.dart';
class PhotosState {
  final List<Photo> photos;
  final int page;
  final bool error;
  final String errorMessage;
  final bool nextPhotoLoading;

  PhotosState({
    this.photos,
    this.page,
    this.error,
    this.errorMessage,
    this.nextPhotoLoading,
  });

  PhotosState.initial()
      : photos = [],
        page = 1,
        error = false,
        errorMessage = '',
        nextPhotoLoading = false;

  PhotosState copyWith({
    List<Photo> photos,
    int page,
    bool error,
    String errorMessage,
    bool nextPhotoLoading,
  }) {
    return PhotosState(
      photos: photos ?? this.photos,
      page: page ?? this.page,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage,
      nextPhotoLoading: nextPhotoLoading ?? this.nextPhotoLoading,
    );
  }
}
