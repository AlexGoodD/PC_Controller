import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({super.key, this.onPressed, required this.icon});

  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;


    return FloatingActionButton(
        shape: const OvalBorder(),
        elevation: 0,
        backgroundColor: CustomTheme.presentationButton,
        foregroundColor: Colors.white,
        onPressed: onPressed,
        child: Icon(icon, size: 40)
    );
  }
}