import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/logic/usecases/search_library.dart';
import 'package:library_app/presentation/bloc/library_bloc.dart';
import 'package:library_app/presentation/bloc/library_event.dart';
import 'package:library_app/presentation/bloc/library_state.dart';
import 'package:library_app/util/no_params.dart';
import 'package:mocktail/mocktail.dart';

import '../../shared/mocks.dart';

class MockGetLibrary extends Mock implements GetLibrary {}

class MockSearchLibrary extends Mock implements SearchLibrary {}

class MockSearchLibraryParams extends Mock implements SearchLibraryParams {}

void main() {
  group('LibraryBloc tests', () {
    late GetLibrary getLibrary;
    late SearchLibrary searchLibrary;
    late LibraryBloc libraryBloc;

    final mockLibrary = MockLibrary();
    final mockFailure = MockFailure();

    setUp(() {
      getLibrary = MockGetLibrary();
      searchLibrary = MockSearchLibrary();
      libraryBloc = LibraryBloc(
        getLibrary: getLibrary,
        searchLibrary: searchLibrary,
      );

      registerFallbackValue(NoParams());
    });

    blocTest(
      'Test landed on library screen success',
      setUp: () {
        when(() => getLibrary(any()))
            .thenAnswer((_) => Future.value(Right(mockLibrary)));
      },
      build: () => libraryBloc,
      act: (bloc) => bloc.add(LandedOnLibraryEvent()),
      expect: () => [LibraryLoading(), LibraryLoaded(library: mockLibrary)],
    );

    blocTest(
      'Test landed on library screen failure',
      setUp: () {
        when(() => getLibrary(any()))
            .thenAnswer((_) => Future.value(Left(mockFailure)));
      },
      build: () => libraryBloc,
      act: (bloc) => bloc.add(LandedOnLibraryEvent()),
      expect: () =>
          [LibraryLoading(), LibraryRetrievalFailed(failure: mockFailure)],
    );

    blocTest(
      'Test search library success',
      setUp: () {
        when(() => searchLibrary(const SearchLibraryParams(query: 'query')))
            .thenAnswer((_) => Future.value(Right(mockLibrary)));
      },
      build: () => libraryBloc,
      act: (bloc) => bloc.add(SearchLibraryEvent(query: 'query')),
      expect: () => [LibraryLoaded(library: mockLibrary)],
    );

    blocTest(
      'Test search library failure',
      setUp: () {
        when(() => searchLibrary(const SearchLibraryParams(query: 'query')))
            .thenAnswer((_) => Future.value(Left(mockFailure)));
      },
      build: () => libraryBloc,
      act: (bloc) => bloc.add(SearchLibraryEvent(query: 'query')),
      expect: () => [],
    );
  });
}
