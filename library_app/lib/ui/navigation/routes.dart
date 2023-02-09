abstract class AppRoute {
  final String path;

  AppRoute._(this.path);

  factory AppRoute.library() = _LibraryRoute;
  factory AppRoute.book() = _BookRoute;
}

class _LibraryRoute extends AppRoute {
  _LibraryRoute() : super._('/');
}

class _BookRoute extends AppRoute {
  _BookRoute() : super._('book');
}
