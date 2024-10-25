import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.width,
    this.height = 100,
    required this.child,
    this.function,
    required this.primaryColor, // Color del botón
    this.onPrimaryColor = Colors.white, // Color del texto del botón
  });

  final double width;
  final double height;
  final Widget child;
  final VoidCallback? function;
  final Color primaryColor; // Color del botón
  final Color onPrimaryColor; // Color del texto

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Color del botón
        foregroundColor: onPrimaryColor, // Color del texto
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: function ?? () {},
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center( // Añadido para centrar el texto
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}