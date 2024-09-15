import 'package:client/app.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/modules/categories/bloc/categories_bloc.dart';
import 'package:client/modules/categories/repository/categories_repository.dart';
import 'package:client/modules/categories/services/categories_service.dart';
import 'package:client/modules/follow/bloc/follows_bloc.dart';
import 'package:client/modules/follow/repository/follow_repository.dart';
import 'package:client/modules/follow/service/follow_service.dart';
import 'package:client/modules/profile/bloc/profile_bloc.dart';
import 'package:client/modules/profile/repositories/profile_repository.dart';
import 'package:client/modules/profile/services/profile_service.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository(AuthService())),
        RepositoryProvider(create: (context) => CategoriesRepository(CategoriesService())),
        RepositoryProvider(create: (context) => FollowRepository(FollowService())),
        RepositoryProvider(create: (context) => ProfileRepository(ProfileService())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              appCubit: context.read<AppCubit>(),
            ),
          ),
          BlocProvider(
            create: (context) => CategoriesBloc(context.read<CategoriesRepository>()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              profileRepository: context.read<ProfileRepository>(),
              appCubit: context.read<AppCubit>(),
            ),
          ),
          BlocProvider(
            create: (context) => FollowsBloc(
              followRepository: context.read<FollowRepository>(),
              appCubit: context.read<AppCubit>(),
            ),
          )
        ],
        child: const App(),
      ),
    );
  }
}
