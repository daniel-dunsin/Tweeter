import 'package:client/app.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/modules/categories/bloc/categories_bloc.dart';
import 'package:client/modules/categories/repository/categories_repository.dart';
import 'package:client/modules/categories/services/categories_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 4));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository(AuthService())),
        RepositoryProvider(create: (context) => CategoriesRepository(CategoriesService()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => CategoriesBloc(context.read<CategoriesRepository>()),
          ),
        ],
        child: App(),
      ),
    );
  }
}
