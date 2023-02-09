import 'package:bloc/bloc.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/logic/usecases/search_library.dart';
import 'package:library_app/presentation/bloc/library_event.dart';
import 'package:library_app/presentation/bloc/library_state.dart';
import 'package:library_app/util/no_params.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetLibrary getLibrary;
  final SearchLibrary searchLibrary;

  LibraryBloc({
    required this.getLibrary,
    required this.searchLibrary,
  }) : super(LibraryInitial()) {
    on<LandedOnLibraryEvent>(_handleLandedOnLibraryEvent);
    on<SearchLibraryEvent>(_handleSearchLibraryEvent);
  }

  Future<void> _handleLandedOnLibraryEvent(
    LandedOnLibraryEvent event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading());

    final library = await getLibrary(NoParams());

    emit(
      library.fold(
        (failure) => LibraryRetrievalFailed(failure: failure),
        (library) => LibraryLoaded(library: library),
      ),
    );
  }

  Future<void> _handleSearchLibraryEvent(
    SearchLibraryEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final searchedLibrary = await searchLibrary(
      SearchLibraryParams(
        query: event.query,
      ),
    );

    // ignore any failure in this case
    searchedLibrary.fold(
      (_) => null,
      (library) => emit(LibraryLoaded(library: library)),
    );
  }
}
