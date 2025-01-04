import 'package:bloging_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

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

class UserSignUp implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  UserSignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
      print('''User Sign Up usecase
      email: ${params.email}
      password: ${params.password}
      name: ${params.name}
      ''');

    return await repository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}
