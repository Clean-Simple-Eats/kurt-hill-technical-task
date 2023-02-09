import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/data/datasources/library_file_datasource.dart';
import 'package:library_app/data/file_provider.dart';
import 'package:library_app/data/serialization/library_deserializer.dart';
import 'package:library_app/util/failure.dart';
import 'package:mocktail/mocktail.dart';

import '../../shared/mocks.dart';

class MockFileProvider extends Mock implements FileProvider {}

class MockLibraryDeserializer extends Mock implements LibraryDeserializer {}

void main() {
  group('GetLibrary empty file path', () {
    late FileProvider fileProvider;
    late LibraryDeserializer libraryDeserializer;
    late LibraryFileDatasource datasource;

    setUp(() {
      fileProvider = MockFileProvider();
      libraryDeserializer = MockLibraryDeserializer();
      datasource = LibraryFileDatasource(
        fileName: '',
        fileProvider: fileProvider,
        libraryDeserializer: libraryDeserializer,
      );
    });

    test('Get library with empty file path failure', () async {
      const failure = Failure(message: '');

      final library = await datasource.getLibrary();

      expect(library, equals(const Left(failure)));

      verifyNever(() => fileProvider.getFileContents(any()));
      verifyNever(() => libraryDeserializer.deserialize(any()));
    });
  });

  group('GetLibrary non-empty file path', () {
    late FileProvider fileProvider;
    late LibraryDeserializer libraryDeserializer;
    late LibraryFileDatasource datasource;

    const fileName = 'fileName';

    setUp(() {
      fileProvider = MockFileProvider();
      libraryDeserializer = MockLibraryDeserializer();
      datasource = LibraryFileDatasource(
        fileName: fileName,
        fileProvider: fileProvider,
        libraryDeserializer: libraryDeserializer,
      );
    });

    test('Get library with non-empty file path success', () async {
      const fileContents = 'fileContents';
      final mockLibrary = MockLibrary();

      when(() => fileProvider.getFileContents(fileName))
          .thenAnswer((_) => Future.value(fileContents));

      when(() => libraryDeserializer.deserialize(fileContents))
          .thenReturn(mockLibrary);

      final library = await datasource.getLibrary();

      expect(library, equals(Right(mockLibrary)));
    });

    test('Get library with non-empty file path exception', () async {
      const fileContents = 'fileContents';

      when(() => fileProvider.getFileContents(fileName))
          .thenAnswer((_) => Future.value(fileContents));

      when(() => libraryDeserializer.deserialize(fileContents))
          .thenThrow(Exception());

      final library = await datasource.getLibrary();

      expect(library, equals(isA<Left>()));
    });
  });
}
