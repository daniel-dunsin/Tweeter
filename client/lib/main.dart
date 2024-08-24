import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/modules/categories/bloc/categories_bloc.dart';
import 'package:client/modules/categories/repository/categories_repository.dart';
import 'package:client/modules/categories/services/categories_service.dart';
import 'package:client/modules/follow/repository/follow_repository.dart';
import 'package:client/modules/follow/service/follow_service.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/cubit/app_cubit.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final {
    "initialRoute": initialRoute,
    "user": user
  } = await getInitialRoute();

  runApp(MyApp(
    initialRoute: initialRoute!,
    user: user,
  ));
}

Future<Map<String, dynamic>> getInitialRoute() async {
  String? initialRoute;
  UserModel? user;

  try {
    final accessToken = await LocalStorage.getString(key: localStorageConstants.accessToken);

    if (accessToken != null) {
      final response = await AuthRepository(AuthService()).getUser();
      final userMap = response["data"];
      if (userMap != null) {
        await LocalStorage.setString(key: localStorageConstants.user, value: jsonEncode(userMap));
        initialRoute = PrivateRoutes.rootHome;
        user = UserModel.fromMap(userMap);
      } else {
        initialRoute = AuthRoutes.signUpInitial;
      }
    }
  } catch (e) {
    print(e);
    initialRoute = AuthRoutes.signUpInitial;
  } finally {
    FlutterNativeSplash.remove();
  }

  return {
    "initialRoute": initialRoute,
    "user": user
  };
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  final UserModel? user;

  const MyApp({
    super.key,
    required this.initialRoute,
    this.user,
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => CategoriesBloc(context.read<CategoriesRepository>()),
          ),
        ],
        child: App(
          initialRoute: widget.initialRoute,
          user: widget.user,
        ),
      ),
    );
  }
}
