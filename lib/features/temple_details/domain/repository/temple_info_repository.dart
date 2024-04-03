import 'package:news_app_clean_architecture/features/temple_details/domain/entities/temple_info.dart';

import '../../../../core/resources/data_state.dart';

abstract class TempleInfoRepository {
  // API methods
  Future<DataState<List<TempleInfoEntity>>> getResponse(
      formData, String serviceId);
}
