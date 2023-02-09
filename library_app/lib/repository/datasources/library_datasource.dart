import 'package:dartz/dartz.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/util/failure.dart';

abstract class ILibraryDatasource {
  Future<Either<Failure, Library>> getLibrary();
}
