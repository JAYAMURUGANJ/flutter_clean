import '../../../../core/resources/data_state.dart';
import '../entities/temple_info.dart';

abstract class TempleInfoRepository {
  // API methods
  Future<DataState<List<TempleInfoEntity>>> getResponse(
      formData, String serviceId);
}
