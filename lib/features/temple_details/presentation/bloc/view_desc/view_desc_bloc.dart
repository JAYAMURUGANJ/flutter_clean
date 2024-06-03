import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_details/domain/entities/sculptures.dart';

part 'view_desc_event.dart';
part 'view_desc_state.dart';

class ViewDescBloc extends Bloc<ViewDescEvent, ViewDescState> {
  ViewDescBloc() : super(ViewDescInitial()) {
    on<GetDesc>((event, emit) {
      emit(ShowViewDesc(sculpture: event.sculpture));
    });
    on<CloseDesc>((event, emit) => emit(CloseViewDesc()));
  }
}
