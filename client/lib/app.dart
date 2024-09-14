import 'package:client/config/navigation/routes_config.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  App({super.key});

  final mode = TweeterColors.light();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(329, 700),
      builder: (context, state) {
        ScreenUtil.configure();
        return ToastificationWrapper(
          child: MaterialApp.router(
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
              appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: mode.backgroundColor,
                foregroundColor: mode.secondaryForegroundColor,
                surfaceTintColor: Colors.transparent,
              ),
            ),
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
