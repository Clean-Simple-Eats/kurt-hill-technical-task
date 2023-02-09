import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/logic/usecases/search_library.dart';
import 'package:library_app/util/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../../shared/mocks.dart';

class MockLibraryRepository extends Mock implements ILibraryRepository {}

void main() {
  group('GetLibrary', () {
    late ILibraryRepository repository;
    late SearchLibrary usecase;

    setUp(() {
      repository = MockLibraryRepository();
      usecase = SearchLibrary(repository: repository);
    });

    test('Search library by title', () async {
      final mockLibrary = MockLibrary();
      final mockBook1 = MockBook();
      final mockBook2 = MockBook();
      final mockBook3 = MockBook();
      final mockBook4 = MockBook();

      final books = [
        mockBook1,
        mockBook2,
        mockBook3,
        mockBook4,
      ];

      when(() => mockLibrary.books).thenReturn(books);
      when(() => mockBook1.title).thenReturn('abc');
      when(() => mockBook2.title).thenReturn('def');
      when(() => mockBook3.title).thenReturn('ghi');
      when(() => mockBook4.title).thenReturn('bcd');
      when(() => mockBook1.author).thenReturn('');
      when(() => mockBook2.author).thenReturn('');
      when(() => mockBook3.author).thenReturn('');
      when(() => mockBook4.author).thenReturn('');

      when(() => repository.getLibrary())
          .thenAnswer((_) => Future.value(Right(mockLibrary)));

      final librarySearch1 =
          await usecase(const SearchLibraryParams(query: 'abc'));

      final expected1 = Library(books: [mockBook1]);
      expect(librarySearch1, equals(Right(expected1)));

      final librarySearch2 =
          await usecase(const SearchLibraryParams(query: 'b'));

      final expected2 = Library(books: [mockBook1, mockBook4]);
      expect(librarySearch2, equals(Right(expected2)));

      final librarySearch3 =
          await usecase(const SearchLibraryParams(query: ''));

      final expected3 = Library(books: books);
      expect(librarySearch3, equals(Right(expected3)));
    });

    test('Search library by author', () async {
      final mockLibrary = MockLibrary();
      final mockBook1 = MockBook();
      final mockBook2 = MockBook();
      final mockBook3 = MockBook();
      final mockBook4 = MockBook();

      final books = [
        mockBook1,
        mockBook2,
        mockBook3,
        mockBook4,
      ];

      when(() => mockLibrary.books).thenReturn(books);
      when(() => mockBook1.title).thenReturn('');
      when(() => mockBook2.title).thenReturn('');
      when(() => mockBook3.title).thenReturn('');
      when(() => mockBook4.title).thenReturn('');
      when(() => mockBook1.author).thenReturn('abc');
      when(() => mockBook2.author).thenReturn('def');
      when(() => mockBook3.author).thenReturn('ghi');
      when(() => mockBook4.author).thenReturn('bcd');

      when(() => repository.getLibrary())
          .thenAnswer((_) => Future.value(Right(mockLibrary)));

      final librarySearch1 =
          await usecase(const SearchLibraryParams(query: 'abc'));

      final expected1 = Library(books: [mockBook1]);
      expect(librarySearch1, equals(Right(expected1)));

      final librarySearch2 =
          await usecase(const SearchLibraryParams(query: 'b'));

      final expected2 = Library(books: [mockBook1, mockBook4]);
      expect(librarySearch2, equals(Right(expected2)));

      final librarySearch3 =
          await usecase(const SearchLibraryParams(query: ''));

      final expected3 = Library(books: books);
      expect(librarySearch3, equals(Right(expected3)));
    });

    test('Search library by title and author', () async {
      final mockLibrary = MockLibrary();
      final mockBook1 = MockBook();
      final mockBook2 = MockBook();
      final mockBook3 = MockBook();
      final mockBook4 = MockBook();

      final books = [
        mockBook1,
        mockBook2,
        mockBook3,
        mockBook4,
      ];

      when(() => mockLibrary.books).thenReturn(books);
      when(() => mockBook1.title).thenReturn('cgi');
      when(() => mockBook2.title).thenReturn('wzy');
      when(() => mockBook3.title).thenReturn('plo');
      when(() => mockBook4.title).thenReturn('CGq');
      when(() => mockBook1.author).thenReturn('abc');
      when(() => mockBook2.author).thenReturn('def');
      when(() => mockBook3.author).thenReturn('ghi');
      when(() => mockBook4.author).thenReturn('bcd');

      when(() => repository.getLibrary())
          .thenAnswer((_) => Future.value(Right(mockLibrary)));

      final librarySearch1 =
          await usecase(const SearchLibraryParams(query: 'abc'));

      final expected1 = Library(books: [mockBook1]);
      expect(librarySearch1, equals(Right(expected1)));

      final librarySearch2 =
          await usecase(const SearchLibraryParams(query: 'g'));

      final expected2 = Library(books: [mockBook1, mockBook3, mockBook4]);
      expect(librarySearch2, equals(Right(expected2)));

      final librarySearch3 =
          await usecase(const SearchLibraryParams(query: ''));

      final expected3 = Library(books: books);
      expect(librarySearch3, equals(Right(expected3)));
    });

    test('Search library failure', () async {
      const failure = Failure(message: '');

      when(() => repository.getLibrary())
          .thenAnswer((_) => Future.value(const Left(failure)));

      final library = await usecase(const SearchLibraryParams(query: 'query'));

      expect(library, equals(const Left(failure)));
    });
  });
}
