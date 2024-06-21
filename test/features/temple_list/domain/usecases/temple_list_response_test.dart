import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/models/itms_request.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/repository/temple_list_repository.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/usecases/temple_list_response.dart';

import '../../../../request_handler.dart';
import '../../mocks/migrate_temple_list.dart';
import 'temple_list_response_test.mocks.dart';

@GenerateMocks([TempleListRepository])
void main() {
  // final dioException = DioException(requestOptions: RequestOptions(path: ""));
  const serviceId = "7018";
  final formData = MockRequestHandler(serviceId, [FilterData()]).getFormData();
  final repo = MockTempleListRepository();
  void setUpSuccessforGetArticle() {
    when(repo.getTempleList(formData, serviceId)).thenAnswer(
        (realInvocation) async => DataSuccess(mockListOfTemple, "success"));
  }

  testWidgets('while calling the TempleList usecase we should get Temple list',
      (tester) async {
    setUpSuccessforGetArticle();
    TempleListResponseUseCase getArticles = TempleListResponseUseCase(repo);
    final result = await getArticles(formData, serviceId);
    expect(result.resultSet, mockListOfTemple);
  });
}
