import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/util/failure.dart';
import 'package:library_app/util/no_params.dart';
import 'package:mocktail/mocktail.dart';

import '../../shared/mocks.dart';

class MockLibraryRepository extends Mock implements ILibraryRepository {}

void main() {
  group('GetLibrary', () {
    late ILibraryRepository repository;
    late GetLibrary usecase;

    setUp(() {
      repository = MockLibraryRepository();
      usecase = GetLibrary(repository: repository);
    });

    test('Get library success', () async {
      final mockLibrary = MockLibrary();

      when(() => repository.getLibrary())
          .thenAnswer((_) => Future.value(Right(mockLibrary)));

      final library = await usecase(NoParams());

      expect(library, equals(Right(mockLibrary)));
    });

    test('Get library failure', () async {
      const failure = Failure(message: '');

      when(() => repository.getLibrary())
          .thenAnswer((_) => Future.value(const Left(failure)));

      final library = await usecase(NoParams());

      expect(library, equals(const Left(failure)));
    });
  });
}
