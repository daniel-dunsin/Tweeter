import 'package:client/config/routes.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  final mode = TweeterColors.dark();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
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
    );
  }
}
