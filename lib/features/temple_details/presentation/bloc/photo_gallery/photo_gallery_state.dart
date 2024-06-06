part of 'photo_gallery_bloc.dart';

class PhotoGalleryState {
  final List<dynamic>? photoGallery;
  final String? responseStatus;
  final DioException? error;
  const PhotoGalleryState({this.photoGallery, this.responseStatus, this.error});
}

class PhotoGalleryInitial extends PhotoGalleryState {}

class PhotoGalleryLoading extends PhotoGalleryState {
  const PhotoGalleryLoading();
}

class PhotoGalleryLoaded extends PhotoGalleryState {
  const PhotoGalleryLoaded(List<PhotoGalleryEntity> photoGallery)
      : super(photoGallery: photoGallery);
}

class PhotoGalleryLoadingSomthingWentWrong extends PhotoGalleryState {
  const PhotoGalleryLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class PhotoGalleryLoadingError extends PhotoGalleryState {
  const PhotoGalleryLoadingError(DioException error) : super(error: error);
}
