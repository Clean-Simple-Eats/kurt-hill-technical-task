import 'package:equatable/equatable.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/util/failure.dart';

abstract class LibraryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {}

class LibraryRetrievalFailed extends LibraryState {
  final Failure failure;

  LibraryRetrievalFailed({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

class LibraryLoaded extends LibraryState {
  final Library library;

  LibraryLoaded({
    required this.library,
  });

  @override
  List<Object?> get props => [library];
}
