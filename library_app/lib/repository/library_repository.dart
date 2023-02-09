import 'package:library_app/logic/models/book.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:dartz/dartz.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/repository/cache/books_cache.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/util/failure.dart';

class LibraryRepository implements ILibraryRepository {
  final BooksCache cache;
  final ILibraryDatasource datasource;

  const LibraryRepository({
    required this.cache,
    required this.datasource,
  });

  @override
  Future<Either<Failure, Library>> getLibrary() async {
    final books = await cache.getAllAsync();

    if (books.isNotEmpty) {
      return Right(
        Library(books: books),
      );
    }

    final library = await datasource.getLibrary();
    return library.fold((failure) {
      return Left(failure);
    }, (lib) {
      for (Book book in lib.books) {
        cache.setAsync(book.id, book);
      }

      return Right(lib);
    });
  }
}
