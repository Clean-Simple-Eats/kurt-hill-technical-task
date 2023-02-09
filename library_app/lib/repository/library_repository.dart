import 'package:library_app/logic/models/library.dart';
import 'package:dartz/dartz.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/util/failure.dart';

class LibraryRepository implements ILibraryRepository {
  final ILibraryDatasource datasource;

  const LibraryRepository({
    required this.datasource,
  });

  @override
  Future<Either<Failure, Library>> getLibrary() async {
    return datasource.getLibrary();
  }
}
