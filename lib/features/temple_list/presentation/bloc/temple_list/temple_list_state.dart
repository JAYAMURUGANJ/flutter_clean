import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/temple_list.dart';

abstract class TempleListState extends Equatable {
  final List<dynamic>? templeList;
  final String? responseStatus;
  final DioException? error;

  const TempleListState({this.responseStatus, this.templeList, this.error});

  @override
  List<Object?> get props => [templeList, responseStatus, error];
}

class TempleListLoading extends TempleListState {
  const TempleListLoading();

  @override
  List<Object?> get props => [];
}

class TempleListLoaded extends TempleListState {
  const TempleListLoaded(List<TempleListEntity> templeList)
      : super(templeList: templeList);

  @override
  List<Object?> get props => [templeList];
}

class TempleListLoadingSomthingWentWrong extends TempleListState {
  const TempleListLoadingSomthingWentWrong(String responseStatus)
      : super(responseStatus: responseStatus);

  @override
  List<Object?> get props => [responseStatus];
}

class TempleListLoadingError extends TempleListState {
  const TempleListLoadingError(DioException error) : super(error: error);

  @override
  List<Object?> get props => [error];
}
