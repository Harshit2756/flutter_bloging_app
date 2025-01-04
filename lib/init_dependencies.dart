import 'package:bloging_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/constants/secrets/app_secrets.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/user_sign_in.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Supabase initialization
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseKey);
  getIt.registerLazySingleton(() => supabase.client);

  // Core Dependencies
  getIt.registerLazySingleton(() => AppUserCubit());

  _initAuth();
}

void _initAuth() {
  // Auth Remote Data Source
  getIt
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(getIt()))

    // Auth Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()))

    // Auth Use Cases
    ..registerFactory(() => UserSignIn(getIt()))
    ..registerFactory(() => UserSignUp(getIt()))
    ..registerFactory(() => CurrentUser(getIt()))

    // Auth Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: getIt(),
        userSignIn: getIt(),
        currentUser: getIt(),
        appUserCubit: getIt(),
      ),
    );
}
