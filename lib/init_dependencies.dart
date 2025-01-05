import 'dart:io';

import 'package:bloging_app/core/network/connection_checker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/user_sign_in.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/blog/data/datasources/blog_local_data_source.dart';
import 'features/blog/data/datasources/blog_remote_data_source.dart';
import 'features/blog/data/repositories/blog_repository_impl.dart';
import 'features/blog/domain/repositories/blog_repository.dart';
import 'features/blog/domain/usecases/get_all_blog.dart';
import 'features/blog/domain/usecases/upload_blog.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _loadEnv();
  final supabaseUrl = dotenv.env['SUPERBASE_URL'] ?? '';
  final supabaseKey = dotenv.env['SUPERBASE_KEY'] ?? '';

  _initAuth();
  _initBlog();
  // Supabase initialization
  final supabase =
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  getIt.registerLazySingleton(() => supabase.client);

  // Hive Init
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  getIt.registerLazySingleton(() => Hive.box(name: 'blogs'));

  // Core Dependencies
  getIt.registerLazySingleton(() => AppUserCubit());

  getIt.registerFactory(() => InternetConnection());
  getIt
      .registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(getIt()));
}

void _initAuth() {
  // Auth Remote Data Source
  getIt
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(getIt()))

    // Auth Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          getIt(),
          getIt(),
        ))

    // Auth Use Cases
    ..registerFactory(() => UserSignIn(getIt()))
    ..registerFactory(() => UserSignUp(getIt()))
    ..registerFactory(() => CurrentUser(getIt()))

    // Auth Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: getIt(),
        userLogIn: getIt(),
        currentUser: getIt(),
        appUserCubit: getIt(),
      ),
    );
}

void _initBlog() {
  // Datasource
  getIt
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(getIt()))
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(getIt()))

    // Repository
    ..registerFactory<BlogRepository>(
        () => BlogRepositoryImpl(getIt(), getIt(), getIt()))

    // Usecases
    ..registerFactory(() => UploadBlog(getIt()))
    ..registerFactory(() => GetAllBlogs(getIt()))
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: getIt(),
        getAllBlogs: getIt(),
      ),
    );
}

Future<void> _loadEnv() async {
  try {
    await dotenv.load(fileName: "lib/core/constants/secrets/app_secrets.env");
  } catch (e) {
    print("Failed to load .env file, using environment variables");
    // Fallback to environment variables
    dotenv.env['API_KEY'] = Platform.environment['API_KEY'] ?? '';
    dotenv.env['CONTEXT_KEY'] = Platform.environment['CONTEXT_KEY'] ?? '';
  }
}
