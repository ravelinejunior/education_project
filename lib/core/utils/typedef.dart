import 'package:dartz/dartz.dart';
import 'package:education_project/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef Datamap = Map<String, dynamic>;
