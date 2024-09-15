import 'package:client/config/navigation/routes_config.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _loadAppMode();
  }

  _loadAppMode() async {
    final _brightness = await LocalStorage.getString(key: localStorageConstants.appBrightness);
    if (_brightness != null) {
      final AppBrightness brightness = AppBrightness.values.firstWhere((val) => val.name == _brightness);

      context.read<AppCubit>().setAppMode(context, brightness);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLightMode = context.watch<AppCubit>().state.isLightMode;
    final TweeterColors mode = isLightMode ? TweeterColors.light() : TweeterColors.dark();

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
