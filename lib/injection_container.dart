import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/temple_list/data/repository/district_repository_impl.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/repository/district_repository.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/usecases/district_usecase.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/district/district_bloc.dart';

import '/features/dashboard/data/repository/live_events_repository_impl.dart';
import '/features/dashboard/domain/repository/live_events_repository.dart';
import '/features/dashboard/domain/usecases/live_events_usecase.dart';
import '/features/dashboard/presentation/bloc/current_location/current_location_bloc.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';
import '/features/event_calendar/domain/repository/calendar_event_repository.dart';
import '/features/event_calendar/domain/usecases/calendar_event_usecase.dart';
import '/features/event_calendar/presentation/bloc/calendar_event/calendar_event_bloc.dart';
import '/features/settings/presentation/bloc/theme/theme_bloc.dart';
import '/features/temple_details/data/repository/contact_details_repository_impl.dart';
import '/features/temple_details/data/repository/facility_repository_impl.dart';
import '/features/temple_details/data/repository/photo_gallery_impl.dart';
import '/features/temple_details/data/repository/sculptures_repository_impl.dart';
import '/features/temple_details/data/repository/shrines_details_repository_impl.dart';
import '/features/temple_details/data/repository/temple_info_repository_impl.dart';
import '/features/temple_details/domain/repository/contact_details_repository.dart';
import '/features/temple_details/domain/repository/photo_gallery_repository%20.dart';
import '/features/temple_details/domain/repository/sculptures_repository.dart';
import '/features/temple_details/domain/repository/shrines_details_repository.dart';
import '/features/temple_details/domain/repository/temple_info_repository.dart';
import '/features/temple_details/domain/usecases/contact_details_usecase.dart';
import '/features/temple_details/domain/usecases/facility_usecase.dart';
import '/features/temple_details/domain/usecases/photo_gallery_usecase.dart';
import '/features/temple_details/domain/usecases/sculptures_usecase.dart';
import '/features/temple_details/domain/usecases/shrines_details_usecase.dart';
import '/features/temple_details/domain/usecases/speciality_usecase.dart';
import '/features/temple_details/domain/usecases/temple_info_usecase.dart';
import '/features/temple_details/presentation/bloc/contact_details/contact_details_bloc.dart';
import '/features/temple_details/presentation/bloc/facility/facility_bloc.dart';
import '/features/temple_details/presentation/bloc/photo_gallery/photo_gallery_bloc.dart';
import '/features/temple_details/presentation/bloc/photo_gallery_desc/photo_gallery_desc_cubit.dart';
import '/features/temple_details/presentation/bloc/sculptures/sculptures_bloc.dart';
import '/features/temple_details/presentation/bloc/shrines_details/shrines_bloc.dart';
import '/features/temple_details/presentation/bloc/speciality/speciality_bloc.dart';
import '/features/temple_details/presentation/bloc/temple_info/temple_info_bloc.dart';
import '/features/temple_details/presentation/bloc/temple_timing/temple_timing_bloc.dart';
import 'core/data_sources/ITMS_API_service.dart';
import 'features/event_calendar/data/repository/calendar_event_repository_impl.dart';
import 'features/event_calendar/data/repository/calendar_events_details_repository_impl.dart';
import 'features/event_calendar/domain/repository/calendar_event_details_repository.dart';
import 'features/event_calendar/domain/usecases/calendar_event_details_usecase.dart';
import 'features/event_calendar/presentation/bloc/calendar_event_details/calendar_event_details_bloc.dart';
import 'features/home/presentation/bloc/bottom_navigation/bottom_navigation_cubit.dart';
import 'features/settings/presentation/bloc/selected_favorite_temples/selected_favorite_temples_cubit.dart';
import 'features/temple_details/data/repository/near_by_temples_repository_impl.dart';
import 'features/temple_details/data/repository/speciality_repository_impl.dart';
import 'features/temple_details/data/repository/temple_pooja_repository_impl.dart';
import 'features/temple_details/data/repository/temple_timing_repository_impl.dart';
import 'features/temple_details/domain/repository/facility_repository.dart';
import 'features/temple_details/domain/repository/near_by_temples_repository.dart';
import 'features/temple_details/domain/repository/speciality_repository.dart';
import 'features/temple_details/domain/repository/temple_pooja_repository.dart';
import 'features/temple_details/domain/repository/temple_timing_repository.dart';
import 'features/temple_details/domain/usecases/near_by_temple_usecase.dart';
import 'features/temple_details/domain/usecases/temple_pooja_usecase.dart';
import 'features/temple_details/domain/usecases/temple_timinig_usecase.dart';
import 'features/temple_details/presentation/bloc/near_by_temples/near_by_temples_bloc.dart';
import 'features/temple_details/presentation/bloc/show_nearby_temples/show_nearby_temples_bloc.dart';
import 'features/temple_details/presentation/bloc/temple_pooja/temple_pooja_bloc.dart';
import 'features/temple_list/data/repository/temple_list_repository_impl.dart';
import 'features/temple_list/data/repository/worship_god_list_repository_impl.dart';
import 'features/temple_list/domain/repository/temple_list_repository.dart';
import 'features/temple_list/domain/repository/worship_god_list_repository.dart';
import 'features/temple_list/domain/usecases/temple_list_usecase.dart';
import 'features/temple_list/domain/usecases/worship_god_list_usecase.dart';
import 'features/temple_list/presentation/bloc/temple_list/temple_list_bloc.dart';
import 'features/temple_list/presentation/bloc/worship_god_list/worship_god_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<HRCEApiService>(HRCEApiService(sl()));
  sl.registerSingleton<TempleListRepository>(ItmsRepositoryImpl(sl()));
  sl.registerSingleton<TempleInfoRepository>(TempleInfoRepositoryImpl(sl()));
  sl.registerSingleton<TempleTimingRepository>(
      TempleTimingRepositoryImpl(sl()));
  sl.registerSingleton<TemplePoojaRepository>(TemplePoojaRepositoryImpl(sl()));
  sl.registerSingleton<LiveEventsRepository>(LiveEventsRepositoryImpl(sl()));
  sl.registerSingleton<ContactDetailsRepository>(
      ContactDetailsRepositoryImpl(sl()));
  sl.registerSingleton<CalendarEventRepository>(
      CalendarEventRepositoryImpl(sl()));
  sl.registerSingleton<CalendarEventDetailsRepository>(
      CalendarEventDetailsRepositoryImpl(sl()));
  sl.registerSingleton<NearByTemplesRepository>(
      NearByTemplesRepositoryImpl(sl()));
  sl.registerSingleton<ShrinesDetailsRepository>(
      ShrinesDetailsRepositoryImpl(sl()));
  sl.registerSingleton<SculpturesRepository>(SculpturesRepositoryImpl(sl()));
  sl.registerSingleton<FacilityRepository>(FacilityRepositoryImpl(sl()));
  sl.registerSingleton<SpecialityRepository>(SpecialityRepositoryImpl(sl()));
  sl.registerSingleton<PhotoGalleryRepository>(
      PhotoGalleryRepositoryImpl(sl()));
  sl.registerSingleton<WorshipRepository>(WorshipRepositoryImpl(sl()));
  sl.registerSingleton<DistrictRepository>(DistrictRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<TempleListUseCase>(TempleListUseCase(sl()));
  sl.registerSingleton<TempleInfoUseCase>(TempleInfoUseCase(sl()));
  sl.registerSingleton<TempleTimingUseCase>(TempleTimingUseCase(sl()));
  sl.registerSingleton<TemplePoojaUseCase>(TemplePoojaUseCase(sl()));
  sl.registerSingleton<LiveEventsUseCase>(LiveEventsUseCase(sl()));
  sl.registerSingleton<ContactDetailsUseCase>(ContactDetailsUseCase(sl()));
  sl.registerSingleton<CalendarEventUseCase>(CalendarEventUseCase(sl()));
  sl.registerSingleton<CalendarEventDetailsUseCase>(
      CalendarEventDetailsUseCase(sl()));
  sl.registerSingleton<NearByTemplesUseCase>(NearByTemplesUseCase(sl()));
  sl.registerSingleton<ShrinesDetailsUseCase>(ShrinesDetailsUseCase(sl()));
  sl.registerSingleton<SculpturesUseCase>(SculpturesUseCase(sl()));
  sl.registerSingleton<FacilityUseCase>(FacilityUseCase(sl()));
  sl.registerSingleton<SpecialityUseCase>(SpecialityUseCase(sl()));
  sl.registerSingleton<PhotoGalleryUseCase>(PhotoGalleryUseCase(sl()));
  sl.registerSingleton<WorshipUseCase>(WorshipUseCase(sl()));
  sl.registerSingleton<DistrictUseCase>(DistrictUseCase(sl()));

  //Blocs
  sl.registerFactory<TempleListBloc>(() => TempleListBloc(sl()));
  sl.registerFactory<BottomNavigationCubit>(() => BottomNavigationCubit());
  sl.registerFactory<ThemeBloc>(() => ThemeBloc());
  sl.registerFactory<TempleInfoBloc>(() => TempleInfoBloc(sl()));
  sl.registerFactory<TempleTimingBloc>(() => TempleTimingBloc(sl()));
  sl.registerFactory<TemplePoojaBloc>(() => TemplePoojaBloc(sl()));
  sl.registerFactory<LiveEventsBloc>(() => LiveEventsBloc(sl()));
  sl.registerFactory<ContactDetailsBloc>(() => ContactDetailsBloc(sl()));
  sl.registerFactory<CalendarEventBloc>(() => CalendarEventBloc(sl()));
  sl.registerFactory<CalendarEventDetailsBloc>(
      () => CalendarEventDetailsBloc(sl()));
  sl.registerFactory<NearbyTemplesBloc>(() => NearbyTemplesBloc(sl()));
  sl.registerFactory<ShowNearbyTemplesBloc>(() => ShowNearbyTemplesBloc());
  sl.registerFactory<CurrentLocationBloc>(() => CurrentLocationBloc());
  sl.registerFactory<ShrinesBloc>(() => ShrinesBloc(sl()));
  sl.registerFactory<SculpturesBloc>(() => SculpturesBloc(sl()));
  sl.registerFactory<FacilityBloc>(() => FacilityBloc(sl()));
  sl.registerFactory<SpecialityBloc>(() => SpecialityBloc(sl()));
  sl.registerFactory<PhotoGalleryBloc>(() => PhotoGalleryBloc(sl()));
  sl.registerFactory<PhotoGalleryDescCubit>(() => PhotoGalleryDescCubit());
  sl.registerFactory<WorshipGodListBloc>(() => WorshipGodListBloc(sl()));
  sl.registerFactory<SelectedFavoriteTemplesCubit>(
      () => SelectedFavoriteTemplesCubit());
  sl.registerFactory<DistrictBloc>(() => DistrictBloc(sl()));
}
