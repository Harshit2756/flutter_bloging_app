import 'package:bloging_app/core/errors/exceptions.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

/// [AuthRepositoryImpl] is a concrete class that implements the abstract class AuthRepository.
/// This class uses the AuthRemoteDataSource class to perform authentication operations based on the AuthRepository class.
/// These mwthods are used in usecases [Domain Layer] to perform authentication operations.

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async {
        print('''User Login repository
      email: $email
      password: $password
      ''');

        final user = await remoteDataSource.loginWithEmailPassword(
          email: email,
          password: password,
        );

        print('User: $user');
        return user;
      },
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async {
        print('''User Sign Up repository
          email: $email
          password: $password
          name: $name
          ''');

        return await remoteDataSource.signUpWithEmailPassword(
          name: name,
          email: email,
          password: password,
        );
      },
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      print('User: $user');
      return right(user);
    } on ServerException catch (e) {
      print('Error: ${e.message}');
      return left(Failure(e.message));
    }
  }
}
