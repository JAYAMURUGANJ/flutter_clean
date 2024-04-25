import 'package:news_app_clean_architecture/features/dashboard/domain/entities/whats_new.dart';

import '../../../../core/resources/data_state.dart';


abstract class WhatsNewRepository {
  // API methods
  Future<DataState<List<WhatsNewEntity>>> getResponse(
      formData, String serviceId);
}
