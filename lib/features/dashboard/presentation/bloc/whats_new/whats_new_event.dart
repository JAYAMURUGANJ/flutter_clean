part of 'whats_new_bloc.dart';

abstract class WhatsNewEvent {
  const WhatsNewEvent();
}

class GetWhatsNew extends WhatsNewEvent {
  String? templeId;
  GetWhatsNew({
    this.templeId,
  });
}
