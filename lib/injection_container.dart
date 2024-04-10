import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/settings/presentation/bloc/theme/theme_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/data/repository/temple_info_repository_impl.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/repository/temple_info_repository.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/usecases/temple_info_usecase.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';

import 'core/data_sources/ITMS_API_service.dart';
import 'features/temple_details/data/repository/temple_timing_repository_impl.dart';
import 'features/temple_details/domain/repository/temple_timing_repository.dart';
import 'features/temple_details/domain/usecases/temple_timinig_usecase.dart';
import 'features/temple_list/data/repository/itms_repository_impl.dart';
import 'features/temple_list/domain/repository/itms_repository.dart';
import 'features/temple_list/domain/usecases/itms_response.dart';
import 'features/home/presentation/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'features/temple_list/presentation/bloc/itms/itms_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<HRCEApiService>(HRCEApiService(sl()));

  sl.registerSingleton<ItmsRepository>(ItmsRepositoryImpl(sl()));
  sl.registerSingleton<TempleInfoRepository>(TempleInfoRepositoryImpl(sl()));
  sl.registerSingleton<TempleTimingRepository>(
      TempleTimingRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<ItmsResponseUseCase>(ItmsResponseUseCase(sl()));
  sl.registerSingleton<TempleInfoUseCase>(TempleInfoUseCase(sl()));
  sl.registerSingleton<TempleTimingUseCase>(TempleTimingUseCase(sl()));

  //Blocs
  sl.registerFactory<ITMSBloc>(() => ITMSBloc(sl()));
  sl.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());
  sl.registerFactory<ThemeBloc>(() => ThemeBloc());
  sl.registerFactory<TempleInfoBloc>(() => TempleInfoBloc(sl()));
  sl.registerFactory<TempleTimingBloc>(() => TempleTimingBloc(sl()));
}
