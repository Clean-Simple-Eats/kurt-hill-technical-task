import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/presentation/bloc/library_bloc.dart';
import 'package:library_app/presentation/bloc/library_event.dart';
import 'package:library_app/presentation/bloc/library_state.dart';
import 'package:library_app/ui/widgets/book_list_item.dart';
import 'package:library_app/util/failure.dart';
import 'package:library_app/wiring/injection_container.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildBody();

  Widget _buildBody() {
    return BlocProvider(
      create: (context) {
        final bloc = sl<LibraryBloc>();
        bloc.add(LandedOnLibraryEvent());
        return bloc;
      },
      child: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoading) {
            return _buildLoadingView();
          } else if (state is LibraryLoaded) {
            return _buildLoadedView(state.library);
          } else if (state is LibraryRetrievalFailed) {
            return _buildErrorView(context, state.failure);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedView(Library library) {
    return ListView.builder(
        itemCount: library.books.length,
        itemBuilder: (context, index) {
          final book = library.books[index];
          return BookListItem(
            title: book.title,
            author: book.author,
            imageUrl: book.imageUrl,
            onTap: () {
              print("Hi");
            },
          );
        });
  }

  Widget _buildErrorView(BuildContext context, Failure failure) {
    return Center(
      child: Text(
        failure.message,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
