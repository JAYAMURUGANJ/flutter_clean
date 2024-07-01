part of 'photo_gallery_bloc.dart';

class PhotoGalleryEvent {
  const PhotoGalleryEvent();
}

class GetPhotoGallery extends PhotoGalleryEvent {
  final String templeId;
  GetPhotoGallery({
    required this.templeId,
  });
}
