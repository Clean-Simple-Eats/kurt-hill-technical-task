import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final String author;
  final String publisher;
  final DateTime publicationDate;
  final String genre;
  final List<String> tags;
  final String imageUrl;

  const Book({
    required this.title,
    required this.author,
    required this.publisher,
    required this.publicationDate,
    required this.genre,
    required this.tags,
    required this.imageUrl,
  });

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        publisher = json['publisher'],
        publicationDate = json['publicationDate'],
        genre = json['genre'],
        tags = json['tags'],
        imageUrl = json['image'];

  @override
  List<Object?> get props => [
        title,
        author,
        publisher,
        publicationDate,
        genre,
        tags,
        imageUrl,
      ];
}