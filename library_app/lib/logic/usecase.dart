import 'package:dartz/dartz.dart';
import 'package:library_app/util/failure.dart';

abstract class UseCase<Params, Entity> {
  Future<Either<Failure, Entity>> call(Params params);
}
