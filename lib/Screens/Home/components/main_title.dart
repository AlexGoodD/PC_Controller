import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: CustomTheme.fontSizes["Title"], fontWeight: FontWeight.bold, color: CustomTheme.foreFontColor);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          value,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}