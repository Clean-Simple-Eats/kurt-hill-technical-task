import 'package:get_it/get_it.dart';
import 'package:library_app/data/datasources/library_file_datasource.dart';
import 'package:library_app/data/file_provider.dart';
import 'package:library_app/data/serialization/library_deserializer.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/logic/usecases/search_library.dart';
import 'package:library_app/presentation/bloc/library_bloc.dart';
import 'package:library_app/repository/cache/books_cache.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/repository/library_repository.dart';

final GetIt sl = GetIt.instance;

void initDI() {
  // Bloc
  sl.registerFactory(
    () => LibraryBloc(
      getLibrary: sl(),
      searchLibrary: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetLibrary(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchLibrary(
      repository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ILibraryRepository>(
    () => LibraryRepository(
      cache: sl(),
      datasource: sl(),
    ),
  );

  // Cache
  sl.registerLazySingleton(() => BooksCache());

  // Datasource
  sl.registerLazySingleton(() => FileProvider());
  sl.registerLazySingleton(() => LibraryDeserializer());
  sl.registerLazySingleton<ILibraryDatasource>(() {
    const fileName = String.fromEnvironment("FILE");

    if (fileName.isNotEmpty) {
      return LibraryFileDatasource(
        fileName: fileName,
        fileProvider: sl(),
        libraryDeserializer: sl(),
      );
    } else {
      throw Exception(
          'A filePath should be provided via argument --dart-define=FILE={filePath}');

      // An alternative library datasource could be provided in the case that
      // a filePath is not provided
    }
  });
}
