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

    const double width = 240;
    const double height = 240;

    // Theme Colors
    final primaryColor = isLight? CustomTheme.primaryColor : CustomThemeDark.primaryColor;
    final secondBgColor = isLight? CustomTheme.secondaryBackgroundColor : CustomThemeDark.secondaryBackgroundColor;

    return Container(
      decoration: BoxDecoration(
          color: secondBgColor,
          shape: BoxShape.circle,
          border: Border.all(color: primaryColor, width: 8)
      ),
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Image.asset(
          "assets/images/wirelessicon.png",
        ),
      ),
    );
  }
}