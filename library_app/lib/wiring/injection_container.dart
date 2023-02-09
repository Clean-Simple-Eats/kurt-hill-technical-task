import 'package:get_it/get_it.dart';
import 'package:library_app/data/datasources/library_file_datasource.dart';
import 'package:library_app/data/file_provider.dart';
import 'package:library_app/data/serialization/library_deserializer.dart';
import 'package:library_app/logic/repository/library_repository.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/repository/datasources/library_datasource.dart';
import 'package:library_app/repository/library_repository.dart';

final GetIt sl = GetIt.instance;

initDI() {
  // Use cases
  sl.registerLazySingleton(
    () => GetLibrary(
      repository: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ILibraryRepository>(
    () => LibraryRepository(
      datasource: sl(),
    ),
  );

  // Datasource
  sl.registerLazySingleton(() => FileProvider());
  sl.registerLazySingleton(() => LibraryDeserializer());
  sl.registerLazySingleton<ILibraryDatasource>(() {
    const filePath = String.fromEnvironment("FILE");

    if (filePath.isNotEmpty) {
      return LibraryFileDatasource(
        filePath: filePath,
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
