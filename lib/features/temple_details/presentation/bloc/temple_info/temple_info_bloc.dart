import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/itms_request.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/entities/temple_info.dart';
import '../../../domain/usecases/temple_info_usecase.dart';

part 'temple_info_event.dart';
part 'temple_info_state.dart';

class TempleInfoBloc extends Bloc<TempleInfoEvent, TempleInfoState> {
  final TempleInfoUseCase _getTempleInfoUseCase;
  TempleInfoBloc(this._getTempleInfoUseCase) : super(TempleInfoInitial()) {
    on<GetTempleInfo>(onGetTempleInfo);
  }

  void onGetTempleInfo(
      GetTempleInfo event, Emitter<TempleInfoState> emit) async {
    emit(const TempleInfoLoading());
    String serviceId = "7009";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getTempleInfoUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleInfoLoaded(dataState.resultSet!));
      } else {
        emit(TempleInfoLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "description": "ARULMIGU KAPALEESWARAR TEMPLE, MYLAPORE, CHENNAI- 600004,  \r CHENNAI  DISTRICT.  (TM000001)\r About Temple\r Ptolemy, the Greek Geographer (A.D. 90-168) has referred to Mylapore in his books as Millarpha,. It was apparently a well-known sea port town with a flourishing trade. It must have also been a place of culture, as Saint, Tiruvalluvar the celebrated author of Tirukural, the World-famous ethical treatise, lived in Mylapore nearly 2,000 years ago. The Saivite Saints of the 7th Century, Saint Sambandar and Saint Appear, have sung about the Shrine in their hymns. Mylapore fell into the hands of the Portuguese in A.D.1566, when the temple suffered demolition. The presence temple was rebuilt 300 years ago.\r \r Mayilai  Sri Kapaleeswarar Temple, one of the South Indias most important Saivite worship places in Mylapore, a prime location in the capital city of Tamil Nadu. It attracts many thousands of tourists including foreigners every year. In this temple, the name of the Lord is Sri KAPALEESWARAR. The name of the Goddess is Sri KARPAGAMBAL. It is a lovely temple with a Stately Spire on its eastern side and big tank on its West. The temple and the tank are surrounded by Broad streets on the four sides. The view of the temple and the tank is pictures. Mylapore is on the sea coast and the shore is away by half a mile of thickly populated residential area.", "moolavar_swami_name": "Arulmigu Kapaleeswarar", "moolavar_ambal_name": "Arulmigu Karpagambal", "aagamam_desc": null, "poet_name": "THIRUGNANA SAMBANDHAR", "historical_name": null, "sthala_virutcham": "Punnai Tree", "temple_theertham": "கபாலி தீர்த்தம்", "temple_images": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9hYm91dF90ZW1wbGUvMS8xL2ltYWdlXzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
    emit(TempleInfoLodingError(dataState.error!));
  }
}
