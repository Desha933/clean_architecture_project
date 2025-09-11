import 'package:bookly/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, parameter> {
  Future<Either<Failure, Type>> call([parameter param]);

  // check permission
}

class NoParameter {}
