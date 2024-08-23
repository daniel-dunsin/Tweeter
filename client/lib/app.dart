import 'package:client/config/routes.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  final String initialRoute;
  final mode = TweeterColors.dark();

  App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorKey: navigatorKey,
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
            surfaceTintColor: Colors.transparent,
          ),
        ),
        routes: getRoutes(context),
        initialRoute: initialRoute,
      ),
    );
  }
}
