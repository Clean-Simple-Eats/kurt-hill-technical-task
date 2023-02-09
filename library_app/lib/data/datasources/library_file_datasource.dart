import 'package:library_app/data/file_provider.dart';
import 'package:library_app/data/serialization/library_deserializer.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:dartz/dartz.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/util/failure.dart';

class LibraryFileDatasource implements ILibraryDatasource {
  final String filePath;
  final FileProvider fileProvider;
  final LibraryDeserializer libraryDeserializer;

  const LibraryFileDatasource({
    required this.filePath,
    required this.fileProvider,
    required this.libraryDeserializer,
  });

  @override
  Future<Either<Failure, Library>> getLibrary() async {
    if (filePath.isEmpty) {
      return const Left(
        Failure(
          message: '',
        ),
      );
    }

    final fileContents = await fileProvider.getFileContents(filePath);

    final library = libraryDeserializer.deserialize(fileContents);

    return Right(library);
  }
}
