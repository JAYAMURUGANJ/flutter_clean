part of 'view_desc_bloc.dart';

class ViewDescEvent {
  const ViewDescEvent();
}

class GetDesc extends ViewDescEvent {
  final SculptureEntity sculpture;
  GetDesc(this.sculpture);
}

class CloseDesc extends ViewDescEvent {}
