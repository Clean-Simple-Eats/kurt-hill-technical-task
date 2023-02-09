import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/repository/library_repository.dart';
import 'package:library_app/util/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';

class MockLibraryDataSource extends Mock implements ILibraryDatasource {}

void main() {
  group('GetLibrary', () {
    late ILibraryDatasource datasource;
    late LibraryRepository repository;

    setUp(() {
      datasource = MockLibraryDataSource();
      repository = LibraryRepository(datasource: datasource);
    });

    test('Get library success', () async {
      final mockLibrary = MockLibrary();

      when(() => datasource.getLibrary())
          .thenAnswer((_) => Future.value(Right(mockLibrary)));

      final library = await repository.getLibrary();

      expect(library, equals(Right(mockLibrary)));
    });

    test('Get library failure', () async {
      const failure = Failure(message: '');

      when(() => datasource.getLibrary())
          .thenAnswer((_) => Future.value(const Left(failure)));

      final library = await repository.getLibrary();

      expect(library, equals(const Left(failure)));
    });
  });
}
