import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/presentation/bloc/library_bloc.dart';
import 'package:library_app/presentation/bloc/library_event.dart';
import 'package:library_app/presentation/bloc/library_state.dart';
import 'package:library_app/ui/navigation/routes.dart';
import 'package:library_app/ui/widgets/book_list_item.dart';
import 'package:library_app/ui/widgets/search_bar.dart';
import 'package:library_app/util/failure.dart';
import 'package:library_app/wiring/injection_container.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildBody(context);

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Library',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: BlocProvider(
          create: (context) {
            final bloc = sl<LibraryBloc>();
            bloc.add(LandedOnLibraryEvent());
            return bloc;
          },
          child: Column(
            children: [
              BlocBuilder<LibraryBloc, LibraryState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SearchBar(
                      onTextChanged: (text) {
                        BlocProvider.of<LibraryBloc>(context).add(
                          SearchLibraryEvent(query: text),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<LibraryBloc, LibraryState>(
                buildWhen: (context, state) =>
                    state is LibraryLoading ||
                    state is LibraryLoaded ||
                    state is LibraryRetrievalFailed ||
                    state is LibraryInitial,
                builder: (context, state) {
                  if (state is LibraryLoading) {
                    return _buildLoadingView();
                  } else if (state is LibraryLoaded) {
                    return Expanded(
                      child: _buildLoadedView(state.library),
                    );
                  } else if (state is LibraryRetrievalFailed) {
                    return _buildErrorView(context, state.failure);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedView(Library library) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: library.books.length,
          itemBuilder: (context, index) {
            final book = library.books[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BookListItem(
                title: book.title,
                author: book.author,
                imageUrl: book.imageUrl,
                onTap: () {
                  context.go('/${AppRoute.book().path}', extra: book);
                },
              ),
            );
          }),
    );
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
