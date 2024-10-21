import 'package:flutter/material.dart';
import 'package:pc_controller_master/components/main_button.dart';

class NavToButton extends StatelessWidget {
  const NavToButton({super.key, required this.value, required this.onPress});

  final String value;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double buttonWidth = mediaQuery.size.width * 0.8;
    const double buttonHeight = 51.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: MainButton(
        width: buttonWidth,
        height: buttonHeight,
        function: onPress,
        child: CustomTextButton(
            text: value
        ),
      ),
    );
  }
}