part of 'contact_details_bloc.dart';

class ContactDetailsState {
  final List<dynamic>? contactDetails;
  final String? responseStatus;
  final DioException? error;
  const ContactDetailsState(
      {this.contactDetails, this.responseStatus, this.error});
}

class ContactDetailsInitial extends ContactDetailsState {}

class ContactDetailsLoading extends ContactDetailsState {
  const ContactDetailsLoading();
}

class ContactDetailsLoaded extends ContactDetailsState {
  const ContactDetailsLoaded(List<ContactDetailsEntity> contactDetails)
      : super(contactDetails: contactDetails);
}

class ContactDetailsLoadingSomthingWentWrong extends ContactDetailsState {
  const ContactDetailsLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class ContactDetailsLoadingError extends ContactDetailsState {
  const ContactDetailsLoadingError(DioException error) : super(error: error);
}
