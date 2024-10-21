import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    final primaryColor = isLight ? CustomTheme.primaryColor : CustomThemeDark.primaryColor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
      ),
      onPressed: onPressed,
      child: SizedBox(
          height: 120,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          )
      ),
    );
  }
}