import 'package:blog/core/error/failure.dart';
import 'package:blog/core/usecase/usercase.dart';
import 'package:blog/core/entities/user.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, SignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await authRepository.userSignUp(
        name: params.name, email: params.email, password: params.password);
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
