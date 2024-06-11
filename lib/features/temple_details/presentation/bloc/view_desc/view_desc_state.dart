part of 'view_desc_bloc.dart';

class ViewDescState {
  const ViewDescState();
}

class ViewDescInitial extends ViewDescState {}

class ShowViewDesc extends ViewDescState {
  final SculptureEntity sculpture;

  ShowViewDesc({required this.sculpture});
}

class CloseViewDesc extends ViewDescState {}
