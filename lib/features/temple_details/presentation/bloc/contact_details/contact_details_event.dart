part of 'contact_details_bloc.dart';

class ContactDetailsEvent {
  const ContactDetailsEvent();
}

class GetContactDetails extends ContactDetailsEvent {
  final String templeId;
  GetContactDetails({
    required this.templeId,
  });
}
