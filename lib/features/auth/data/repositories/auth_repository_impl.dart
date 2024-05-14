import 'package:blog/core/error/failure.dart';
import 'package:blog/core/error/server_exception.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:blog/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> userLogin(
      {required String email, required String password}) async {
    return _getUser(
      () async => authRemoteDataSource.userLogin(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> userSignUp(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => await authRemoteDataSource.userSignUp(
          name: name, email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, void>> userSignOut() async {
    try {
      await authRemoteDataSource.userSignOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
