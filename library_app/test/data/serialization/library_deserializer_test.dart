import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/data/serialization/library_deserializer.dart';
import 'package:library_app/logic/models/book.dart';
import 'package:library_app/logic/models/library.dart';

const jsonData = """[
  {
    "title": "To Kill a Mockingbird",
    "author": "Harper Lee",
    "publisher": "J. B. Lippincott & Co.",
    "publication_date": "July 11, 1960",
    "genre": "Novel",
    "tags": ["Classic", "Southern Gothic", "Law"],
    "image": "https://picsum.photos/200"
  },
  {
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "publisher": "Charles Scribner's Sons",
    "publication_date": "April 10, 1925",
    "genre": "Novel",
    "tags": ["Classic", "Jazz Age", "American Dream"],
    "image": "https://picsum.photos/200"
  },
  {
    "title": "Pride and Prejudice",
    "author": "Jane Austen",
    "publisher": "Thomas Egerton",
    "publication_date": "January 28, 1813",
    "genre": "Novel",
    "tags": ["Classic", "Romance", "Society"],
    "image": "https://picsum.photos/200"
  }
]""";

void main() {
  group('Deserialize Library', () {
    late LibraryDeserializer libraryDeserializer;

    final books = [
      Book(
        title: "To Kill a Mockingbird",
        author: "Harper Lee",
        publisher: "J. B. Lippincott & Co.",
        publicationDate: "July 11, 1960",
        genre: "Novel",
        tags: const ["Classic", "Southern Gothic", "Law"],
        imageUrl: "https://picsum.photos/200",
      ),
      Book(
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        publisher: "Charles Scribner's Sons",
        publicationDate: "April 10, 1925",
        genre: "Novel",
        tags: const ["Classic", "Jazz Age", "American Dream"],
        imageUrl: "https://picsum.photos/200",
      ),
      Book(
        title: "Pride and Prejudice",
        author: "Jane Austen",
        publisher: "Thomas Egerton",
        publicationDate: "January 28, 1813",
        genre: "Novel",
        tags: const ["Classic", "Romance", "Society"],
        imageUrl: "https://picsum.photos/200",
      ),
    ];

    final library = Library(books: books);

    setUp(() {
      libraryDeserializer = LibraryDeserializer();
    });

    test('Deserialize library json data', () async {
      final deserializedLibrary = libraryDeserializer.deserialize(jsonData);

      expect(deserializedLibrary, library);
    });
  });
}
