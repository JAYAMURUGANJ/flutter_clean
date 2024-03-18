import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/core/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/temple/data/repository/temple_repository_impl.dart';
import 'package:news_app_clean_architecture/features/temple/domain/repository/temple_repository.dart';
import 'package:news_app_clean_architecture/features/temple/domain/usecases/get_temple.dart';
import 'package:news_app_clean_architecture/features/temple/presentation/bloc/temple/remote/temple_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<HRCEApiService>(HRCEApiService(sl()));

  sl.registerSingleton<TempleRepository>(TempleRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetTempleUseCase>(GetTempleUseCase(sl()));

  //Blocs
  sl.registerFactory<TempleListBloc>(() => TempleListBloc(sl()));
}
