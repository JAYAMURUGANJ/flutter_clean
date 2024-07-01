import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/photo_gallery.dart';

part 'photo_gallery_desc_state.dart';

class PhotoGalleryDescCubit extends Cubit<PhotoGalleryDescState> {
  PhotoGalleryDescCubit() : super(PhotoGalleryDescInitial());

  closePhotoGalleryDesc() {
    emit(PhotoGalleryDescInitial());
  }

  viewPhotoGalleryDesc(PhotoGalleryEntity photoGalleryDesc) {
    emit(PhotoGalleryDescLoaded(photoGalleryDesc));
  }
}
