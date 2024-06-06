part of 'photo_gallery_desc_cubit.dart';

class PhotoGalleryDescState {
  const PhotoGalleryDescState();
}

class PhotoGalleryDescInitial extends PhotoGalleryDescState {}

class PhotoGalleryDescLoaded extends PhotoGalleryDescState {
  final PhotoGalleryEntity photoGalleryDesc;
  PhotoGalleryDescLoaded(this.photoGalleryDesc);
}
