import 'package:library_app/data/file_provider.dart';
import 'package:library_app/data/serialization/library_deserializer.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:dartz/dartz.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/util/failure.dart';

class LibraryFileDatasource implements ILibraryDatasource {
  final String fileName;
  final FileProvider fileProvider;
  final LibraryDeserializer libraryDeserializer;

  const LibraryFileDatasource({
    required this.fileName,
    required this.fileProvider,
    required this.libraryDeserializer,
  });

  @override
  Future<Either<Failure, Library>> getLibrary() async {
    try {
      if (fileName.isEmpty) {
        return const Left(
          Failure(
            message: '',
          ),
        );
      }

      final fileContents = await fileProvider.getFileContents(fileName);

      final library = libraryDeserializer.deserialize(fileContents);

      return Right(library);
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }
}
