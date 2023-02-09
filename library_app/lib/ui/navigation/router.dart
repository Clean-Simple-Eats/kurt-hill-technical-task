import 'package:go_router/go_router.dart';
import 'package:library_app/logic/models/book.dart';
import 'package:library_app/ui/navigation/routes.dart';
import 'package:library_app/ui/screens/book_screen.dart';
import 'package:library_app/ui/screens/library_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoute.library().path,
      builder: (context, state) {
        return const LibraryScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoute.book().path,
          builder: (context, state) {
            return BookScreen(book: state.extra as Book);
          },
        ),
      ],
    ),
  ],
);
