import 'package:client/home.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:client/shared/theme/index.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:flutter/material.dart';
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
  AppColorMode? colorMode;

  @override
  initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 4));
    FlutterNativeSplash.remove();

    setState(() async {
      colorMode = (await LocalStorage.getAny<AppColorMode>(
              key: LocalStorageEnum.theme)) ??
          AppColorMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mode = colorMode == AppColorMode.light
        ? TweeterColors.light()
        : TweeterColors.dark();

    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Tweeter',
        theme: ThemeData(
          useMaterial3: true,
          textTheme:
              ThemeData().textTheme.apply(fontFamily: FontFamily.poppins),
        ).copyWith(
          extensions: [
            mode,
          ],
          scaffoldBackgroundColor: mode.backgroundColor,
          appBarTheme: AppBarTheme().copyWith(),
        ),
        home: Home(),
      ),
    );
  }
}
