import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LandedOnLibraryEvent extends LibraryEvent {}

class SearchLibraryEvent extends LibraryEvent {
  final String query;

  SearchLibraryEvent({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}
