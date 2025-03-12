import 'package:fpdart/fpdart.dart';
import 'package:cricket_poc/Services/Exception/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef FutureVoid = Future<void>;

typedef OnPressed = void Function()?;
