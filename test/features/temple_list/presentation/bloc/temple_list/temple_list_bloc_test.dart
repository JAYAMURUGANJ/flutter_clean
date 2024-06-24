import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/usecases/temple_list_usecase.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/temple_list/temple_list_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/temple_list/temple_list_event.dart';
import 'package:news_app_clean_architecture/features/temple_list/presentation/bloc/temple_list/temple_list_state.dart';

import '../../../mocks/migrate_temple_list.dart';
import 'temple_list_bloc_test.mocks.dart';

@GenerateMocks([TempleListUseCase])
void main() {
  group("Test-TempleListBloc", () {
    late MockTempleListUseCase usecase;
    late TempleListBloc templeListBloc;

    setUp(() {
      usecase = MockTempleListUseCase();
      templeListBloc = TempleListBloc(usecase);
    });

    tearDown(() {
      templeListBloc.close();
    });

    void mockGetTempleListSuccess() {
      when(usecase.call(any, any)).thenAnswer(
        (_) async => DataSuccess(mockListOfTemple, "SUCCESS"),
      );
    }

    test('Initial Bloc State-TempleListLoading', () {
      expect(templeListBloc.state, const TempleListLoading());
    });

    blocTest<TempleListBloc, TempleListState>(
      'Sucess Bloc State-[TempleListLoading, TempleListLoaded]',
      build: () {
        mockGetTempleListSuccess();
        return templeListBloc;
      },
      act: (bloc) {
        bloc.add(GetTempleList(seniorgradeTemples: "Y"));
      },
      expect: () => [
        const TempleListLoading(),
        TempleListLoaded(mockListOfTemple),
      ],
      verify: (_) {
        verify(usecase.call(any, any)).called(1);
      },
    );
  });
}
