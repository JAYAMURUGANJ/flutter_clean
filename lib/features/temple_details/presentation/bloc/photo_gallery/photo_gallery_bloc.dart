import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/photo_gallery.dart';
import '/core/models/itms_request.dart';
import '/core/resources/data_state.dart';
import '/core/resources/itms_request_handler.dart';
import '/features/temple_details/domain/usecases/photo_gallery_usecase.dart';

part 'photo_gallery_event.dart';
part 'photo_gallery_state.dart';

class PhotoGalleryBloc extends Bloc<PhotoGalleryEvent, PhotoGalleryState> {
  final PhotoGalleryUseCase _getPhotoGalleryUseCase;
  List<PhotoGalleryEntity> photoGallery = [];
  PhotoGalleryBloc(this._getPhotoGalleryUseCase)
      : super(PhotoGalleryInitial()) {
    on<GetPhotoGallery>(onGetPhotoGallery);
  }

  void onGetPhotoGallery(
      GetPhotoGallery event, Emitter<PhotoGalleryState> emit) async {
    emit(const PhotoGalleryLoading());
    String serviceId = "7014";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getPhotoGalleryUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        photoGallery = dataState.resultSet!;
        emit(PhotoGalleryLoaded(photoGallery));
      } else {
        emit(PhotoGalleryLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc!));
      }
    }
    if (dataState is DataFailed) {
      emit(PhotoGalleryLoadingError(dataState.error!));
    }
  }
}
