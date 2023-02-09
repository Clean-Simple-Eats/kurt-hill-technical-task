import 'package:library_app/logic/models/book.dart';
import 'package:library_app/repository/cache/in_memory_cache.dart';

typedef BooksCache = InMemoryCache<String, Book>;
