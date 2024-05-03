import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/usecases/contact_details_usecase.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/contact_details.dart';

part 'contact_details_event.dart';
part 'contact_details_state.dart';

class ContactDetailsBloc
    extends Bloc<ContactDetailsEvent, ContactDetailsState> {
  final ContactDetailsUseCase _getContactDetailsUseCase;
  ContactDetailsBloc(this._getContactDetailsUseCase)
      : super(ContactDetailsInitial()) {
    on<GetContactDetails>(onGetTempleContacts);
  }

  void onGetTempleContacts(
      GetContactDetails event, Emitter<ContactDetailsState> emit) async {
    String serviceId = "7013";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getContactDetailsUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(ContactDetailsLoaded(dataState.resultSet!));
      } else {
        emit(ContactDetailsLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
//[ { "result_set": [ { "temple_name": "Arulmigu Kapaleeswarar Temple", "temple_doorno": "12/1, North Mada Street", "temple_location": "Mylapore, Chennai", "pincode": "600004", "landline": "044-24641670", "emailid": "jceochn_1[dot]hrce[at]tn[dot]gov[dot]in", "district_name": "Chennai", "temple_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ4L2ltYWdlXzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
  }
}
