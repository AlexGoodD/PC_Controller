import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/Home/home.dart';
import 'package:pc_controller_master/settings/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting a boilerplateless access to the MediaQuery
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final Brightness brightness = mediaQuery.platformBrightness;
    final isLight = brightness == Brightness.light;

    // Theme Colors
    final primaryColor = isLight ? CustomTheme.primaryColor : CustomThemeDark.primaryColor;
    final primaryBgColor = isLight ? CustomTheme.backgroundColor : CustomThemeDark.backgroundColor;
    final bottomSheetBgColor = isLight? CustomTheme.bottomSheetBg : CustomThemeDark.bottomSheetBg;
    final headerBgColor = isLight ? CustomTheme.headerColor : CustomThemeDark.headerColor;

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: brightness,
        scaffoldBackgroundColor: primaryBgColor,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: bottomSheetBgColor,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: bottomSheetBgColor,
          iconColor: primaryColor,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: headerBgColor
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
