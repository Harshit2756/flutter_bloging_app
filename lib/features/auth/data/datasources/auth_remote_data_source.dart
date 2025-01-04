import 'package:bloging_app/core/errors/exceptions.dart';
import 'package:bloging_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

/// [AuthRemoteDataSource] is an abstract class that defines the structure of the remote data source. so if we want to change the data source in the future, we can just implement this class.
/// also where ever we want to use this data source we can use this abstract class as a type ,so when changing the implementation we don't have to change the type of the variable everywhere.
/// This class handles Calls to the remote server to perform authentication operations.
/// This class is responsible for handling all the network calls related to authentication.

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel?> getCurrentUser();

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      print('''User Login data source
      email: $email
      password: $password
      ''');

      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      print('''User Login data source
      response: ${response.user}
      ''');
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      print(e.message);
      throw ServerException(e.message);
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
