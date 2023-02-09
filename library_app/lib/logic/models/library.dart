import 'package:equatable/equatable.dart';
import 'package:library_app/logic/models/book.dart';

class Library extends Equatable {
  final List<Book> books;

  const Library({
    required this.books,
  });

  @override
  List<Object?> get props => [books];
}
