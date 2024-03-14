import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/temple/domain/entities/temple.dart';

abstract class TempleRepository {
  // API methods
  Future<DataState<List<TempleEntity>>> getTempleList(String formData);
}
