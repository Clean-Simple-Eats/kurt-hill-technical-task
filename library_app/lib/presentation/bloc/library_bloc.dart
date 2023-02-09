import 'package:bloc/bloc.dart';
import 'package:library_app/logic/usecases/get_library.dart';
import 'package:library_app/presentation/bloc/library_event.dart';
import 'package:library_app/presentation/bloc/library_state.dart';
import 'package:library_app/util/no_params.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetLibrary getLibrary;

  LibraryBloc({
    required this.getLibrary,
  }) : super(LibraryInitial()) {
    on<LandedOnLibraryEvent>(_handleLandedOnLibraryEvent);
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
}
