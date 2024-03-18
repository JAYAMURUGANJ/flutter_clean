import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/temple.dart';

abstract class TempleListState extends Equatable {
  final List<TempleEntity>? templeList;
  final String? responseStatus;
  final DioException? error;

  const TempleListState({this.responseStatus, this.templeList, this.error});

  @override
  List<Object> get props => [templeList!, error!, responseStatus!];
}

class TempleListLoading extends TempleListState {
  const TempleListLoading();
}

class TempleListLoaded extends TempleListState {
  const TempleListLoaded(List<TempleEntity> templeList)
      : super(templeList: templeList);
}

class TempleListLoadingSomthingWentWrong extends TempleListState {
  const TempleListLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);
}

class TempleListLodingError extends TempleListState {
  const TempleListLodingError(DioException error) : super(error: error);
}
