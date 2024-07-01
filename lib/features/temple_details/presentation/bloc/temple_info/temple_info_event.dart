part of 'temple_info_bloc.dart';

abstract class TempleInfoEvent {
  const TempleInfoEvent();
}

class GetTempleInfo extends TempleInfoEvent {
  String templeId;
  GetTempleInfo({
    required this.templeId,
  });
}
