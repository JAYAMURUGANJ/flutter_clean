import 'package:news_app_clean_architecture/features/temple_details/domain/entities/near_by_temples.dart';

import '../../../../core/resources/data_state.dart';

abstract class NearByTemplesRepository {
  // API methods
  Future<DataState<List<NearByTemplesEntity>>> getResponse(
      formData, String serviceId);
}
