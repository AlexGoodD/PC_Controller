import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
        required this.width,
        this.height = 64,
        required this.child,
        this.function});

  final double width;
  final double height;
  final Widget child;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    // Theme Colors
    final primaryColor = isLight ? CustomTheme.primaryColor : CustomThemeDark.primaryColor;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
        ),
        onPressed: function ?? () {},
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: child,
          ),
        )
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white));
  }
}

