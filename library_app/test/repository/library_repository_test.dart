import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/repository/cache/books_cache.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/repository/library_repository.dart';
import 'package:library_app/util/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';

class MockBooksCache extends Mock implements BooksCache {}

class MockLibraryDataSource extends Mock implements ILibraryDatasource {}

void main() {
  group('GetLibrary', () {
    late BooksCache cache;
    late ILibraryDatasource datasource;
    late LibraryRepository repository;

    setUp(() {
      cache = BooksCache();
      datasource = MockLibraryDataSource();
      repository = LibraryRepository(cache: cache, datasource: datasource);
    });

    test('Get library success', () async {
      final mockLibrary = MockLibrary();
      final mockBook1 = MockBook();
      final mockBook2 = MockBook();
      const mockBook1Id = 'id1';
      const mockBook2Id = 'id2';

      when(() => mockBook1.id).thenReturn(mockBook1Id);
      when(() => mockBook2.id).thenReturn(mockBook2Id);

      when(() => mockLibrary.books).thenReturn([mockBook1, mockBook2]);

      when(() => datasource.getLibrary())
          .thenAnswer((_) => Future.value(Right(mockLibrary)));

      final library = await repository.getLibrary();

      expect(library, equals(Right(mockLibrary)));

      verifyInOrder([
        () => cache.setAsync(mockBook1Id, mockBook1),
        () => cache.setAsync(mockBook2Id, mockBook2),
      ]);
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
