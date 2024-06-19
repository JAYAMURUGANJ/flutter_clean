import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/temple_list_response.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/usecases/temple_list_response.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/temple_list/temple_list_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/temple_list/temple_list_event.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/temple_list/temple_list_state.dart';

class MockTempleListUseCase extends Mock implements TempleResponseUseCase {}

void main() {
  group("Temple List bloc", () {
    final getItmsResponseUseCase = MockTempleListUseCase();
    const templeDataJson = {
      "temple_id": 1,
      "temple_name":
          "Arulmigu Kapaleeswarar Temple, Mylapore, Chennai - 600004",
      "ttemple_name":
          "அருள்மிகு கபாலீசுவரர் திருக்கோயில், மயிலாப்பூர், சென்னை - 600004",
      "juris_office_code": 216,
      "district_code": "02",
      "taluk_code": "08",
      "village_code": "004",
      "temple_typecode": 1,
      "institute_categorycode": 1,
      "templesection_code": 3,
      "management_typecode": 1,
      "management_subtype_code": 1,
      "degree_360view":
          "https://mylaikapaleeswarar.hrce.tn.gov.in/resources/docs/virtualtour/1/index.html",
      "temple_latitude": "13.033842927075",
      "temple_langitude": "80.269940923909",
      "maintower_image": [
        {
          "file_location":
              "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ2L2RvY3VtZW50XzEuanBn"
        }
      ]
    };
    var temple = ItmsResponseEntity.fromJson(templeDataJson);

    when(() => MockTempleListUseCase())
        .thenReturn(Stream.fromIterable([temple]) as MockTempleListUseCase);
    blocTest<TempleListBloc, TempleListState>(
      'Temple List bloc loaded successfully',
      build: () => TempleListBloc(getItmsResponseUseCase),
      act: (bloc) => bloc.add(GetTempleList(seniorgradeTemples: "Y")),
      expect: () => <TempleListState>[
        TempleListLoaded([temple])
      ],
    );
  });
}
