import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class MainHomeArt extends StatelessWidget {
  const MainHomeArt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final isLight = brightness == Brightness.light;

    const double width = 300;
    const double height = 300;

    // Theme Colors
    final primaryColor = isLight? CustomTheme.primaryColor : CustomThemeDark.primaryColor;
    final secondBgColor = isLight? CustomTheme.secondaryBackgroundColor : CustomThemeDark.secondaryBackgroundColor;

    return Container(
      width: width,
      height: height,
        child: Image.asset(
          "assets/images/wirelessicon.png",
        ),
    );
  }
}