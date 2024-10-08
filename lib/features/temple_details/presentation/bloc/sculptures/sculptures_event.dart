part of 'sculptures_bloc.dart';

class SculpturesEvent {
  const SculpturesEvent();
}

class GetSculpturesEvent extends SculpturesEvent {
  final String templeId;
  GetSculpturesEvent({
    required this.templeId,
  });
}

class GetSculptureDescEvent extends SculpturesEvent {
  final SculptureEntity sculpture;
  GetSculptureDescEvent({
    required this.sculpture,
  });
}
