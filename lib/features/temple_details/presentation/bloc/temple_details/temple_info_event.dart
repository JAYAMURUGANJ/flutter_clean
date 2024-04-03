part of 'temple_info_bloc.dart';

class TempleInfoEvent extends Equatable {
  const TempleInfoEvent();

  @override
  List<Object> get props => [];
}

class GetTempleInfo extends TempleInfoEvent {
  String templeId;
  GetTempleInfo({
    required this.templeId,
  });
}
