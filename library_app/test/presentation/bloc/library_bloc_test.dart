import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/presentation/bloc/library_bloc.dart';
import 'package:library_app/presentation/bloc/library_event.dart';
import 'package:library_app/presentation/bloc/library_state.dart';
import 'package:library_app/util/failure.dart';
import 'package:library_app/util/no_params.dart';
import 'package:mocktail/mocktail.dart';

import '../../shared/mocks.dart';

class MockGetLibrary extends Mock implements GetLibrary {}

// class MockLibraryBloc extends MockBloc<LibraryEvent, LibraryState>
//     implements LibraryBloc {}

void main() {
  group('LibraryBloc tests', () {
    late GetLibrary getLibrary;
    late LibraryBloc libraryBloc;

    final mockLibrary = MockLibrary();
    final mockFailure = MockFailure();

    setUp(() {
      getLibrary = MockGetLibrary();
      libraryBloc = LibraryBloc(getLibrary: getLibrary);

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
  });
}
