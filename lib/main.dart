import 'package:bloging_app/core/theme/theme.dart';
import 'package:bloging_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';
import 'features/blog/presentation/pages/blog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => getIt<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt<BlogBloc>(),
      ),
      
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});


  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home:  BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsUserLoggedIn());
  }
}
