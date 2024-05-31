part of 'shrines_bloc.dart';

class ShrinesEvent {
  const ShrinesEvent();
}

class GetShrinesEvent extends ShrinesEvent {
  final String templeId;
  GetShrinesEvent({
    required this.templeId,
  });
}
