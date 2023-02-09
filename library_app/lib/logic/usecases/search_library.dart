import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/logic/usecase.dart';
import 'package:library_app/util/failure.dart';

class SearchLibrary implements UseCase<SearchLibraryParams, Library> {
  final ILibraryRepository repository;

  const SearchLibrary({
    required this.repository,
  });

  @override
  Future<Either<Failure, Library>> call(SearchLibraryParams params) async {
    final query = params.query.toLowerCase();

    final library = await repository.getLibrary();

    return library.fold((failure) => Left(failure), (lib) {
      final filteredBooks = lib.books.where((book) {
        return book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query);
      }).toList();

      return Right(Library(books: filteredBooks));
    });
  }
}

class SearchLibraryParams extends Equatable {
  final String query;

  const SearchLibraryParams({required this.query});

  @override
  List<Object?> get props => [query];
}
