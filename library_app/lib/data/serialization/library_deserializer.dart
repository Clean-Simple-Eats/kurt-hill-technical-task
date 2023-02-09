import 'dart:convert';

import 'package:library_app/logic/models/book.dart';
import 'package:library_app/logic/models/library.dart';

class LibraryDeserializer {
  Library deserialize(String json) {
    final List<dynamic> library = jsonDecode(json);

    final books = library.map((element) {
      final bookJson = element as Map<String, dynamic>;
      return Book.fromJson(bookJson);
    }).toList();

    return Library(books: books);
  }
}
