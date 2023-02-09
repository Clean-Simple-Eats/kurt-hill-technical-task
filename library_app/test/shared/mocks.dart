import 'package:library_app/logic/models/book.dart';
import 'package:library_app/logic/models/library.dart';
import 'package:library_app/util/failure.dart';
import 'package:mocktail/mocktail.dart';

class MockLibrary extends Mock implements Library {}

class MockBook extends Mock implements Book {}

class MockFailure extends Mock implements Failure {}
