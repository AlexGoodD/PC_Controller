import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, this.onPressed, this.text = ""});
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey.shade400,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
      ),
      child: SizedBox(
        width: 80,
        height: 50,
        child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white
              ),
            )
        ),
      ),
    );
  }
}