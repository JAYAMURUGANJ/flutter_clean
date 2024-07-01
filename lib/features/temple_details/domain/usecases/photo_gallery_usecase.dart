import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/photo_gallery.dart';
import '../repository/photo_gallery_repository .dart';

class PhotoGalleryUseCase
    implements UseCase<DataState<List<PhotoGalleryEntity>>, void> {
  final PhotoGalleryRepository _photoGalleryRepository;

  PhotoGalleryUseCase(
    this._photoGalleryRepository,
  );

  @override
  Future<DataState<List<PhotoGalleryEntity>>> call(formData, serviceId) async =>
      await _photoGalleryRepository.getResponse(formData, serviceId);
}
