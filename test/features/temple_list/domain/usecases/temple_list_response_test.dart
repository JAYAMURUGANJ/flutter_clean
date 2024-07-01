import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/models/itms_request.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/resources/itms_request_handler.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/repository/temple_list_repository.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/usecases/temple_list_usecase.dart';

import '../../mocks/migrate_temple_list.dart';
import 'temple_list_response_test.mocks.dart';

@GenerateMocks([TempleListRepository])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env_pro");
  Locales(const Locale("en"));

  group("Test-UseCase", () {
    const serviceId = "7019";
    final formData = ITMSRequestHandler(serviceId, [
      FilterData(degree360Avail: "Y", seniorgradeTemples: "Y")
    ]).getFormData();
    final repo = MockTempleListRepository();

    void mockGetTempleListSuccess() =>
        when(repo.getTempleList(any, any)).thenAnswer(
          (_) async => DataSuccess(mockListOfTemple, "SUCCESS"),
        );

    testWidgets('SUCCESS', (tester) async {
      mockGetTempleListSuccess();
      TempleListUseCase getArticles = TempleListUseCase(repo);
      final result = await getArticles(formData, serviceId);
      expect(result.resultSet, mockListOfTemple);
    });
  });
}
