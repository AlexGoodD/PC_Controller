import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, this.onPressed, this.text = ""});
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: CustomTheme.presentationButton,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
      ),
      child: SizedBox(
        width: 120,
        height: 50,
        child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  //backgroundColor: Colors.red,
              ),
            )
        ),
      ),
    );
  }
}