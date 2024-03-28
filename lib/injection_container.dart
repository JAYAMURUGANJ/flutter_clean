import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/data_sources/remote/ITMS_API_service.dart';
import 'features/temple/data/repository/itms_repository_impl.dart';
import 'features/temple/domain/repository/itms_repository.dart';
import 'features/temple/domain/usecases/itms_response.dart';
import 'features/temple/presentation/bloc/itms/itms_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<HRCEApiService>(HRCEApiService(sl()));

  sl.registerSingleton<ItmsRepository>(ItmsRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<ItmsResponseUseCase>(ItmsResponseUseCase(sl()));

  //Blocs
  sl.registerFactory<ITMSBloc>(() => ITMSBloc(sl()));
}
