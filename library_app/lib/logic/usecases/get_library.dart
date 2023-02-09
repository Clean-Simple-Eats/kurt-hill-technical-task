import 'package:dartz/dartz.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/logic/usecase.dart';
import 'package:library_app/util/failure.dart';
import 'package:library_app/util/no_params.dart';

class GetLibrary implements UseCase<NoParams, Library> {
  final ILibraryRepository repository;

  const GetLibrary({
    required this.repository,
  });

  @override
  Future<Either<Failure, Library>> call(_) async {
    return repository.getLibrary();
  }
}
