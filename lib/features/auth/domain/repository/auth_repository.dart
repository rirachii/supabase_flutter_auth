import 'package:blog/core/error/failure.dart';
import 'package:blog/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> userSignUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> userLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, void>> userSignOut();
}
