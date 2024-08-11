import 'package:client/app.dart';
import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:toastification/toastification.dart';

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
  final mode = TweeterColors.dark();

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
        RepositoryProvider(create: (context) => AuthRepository(AuthService()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          )
        ],
        child: ToastificationWrapper(
          child: MaterialApp(
            title: 'Tweeter',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              textTheme: ThemeData().textTheme.apply(
                    fontFamily: FontFamily.poppins,
                    bodyColor: mode.secondaryForegroundColor,
                  ),
            ).copyWith(
              extensions: [
                mode,
              ],
              scaffoldBackgroundColor: mode.backgroundColor,
              appBarTheme: AppBarTheme().copyWith(
                backgroundColor: mode.backgroundColor,
                foregroundColor: mode.secondaryForegroundColor,
              ),
            ),
            routes: getRoutes(context),
            initialRoute: AuthRoutes.signUpInitial,
          ),
        ),
      ),
    );
  }
}
