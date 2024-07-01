// ignore_for_file: file_names

import '../../../../core/resources/data_state.dart';
import '../entities/photo_gallery.dart';

abstract class PhotoGalleryRepository {
  // API methods
  Future<DataState<List<PhotoGalleryEntity>>> getResponse(
      formData, String serviceId);
}
