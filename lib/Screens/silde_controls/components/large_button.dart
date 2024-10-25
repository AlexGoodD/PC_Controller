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
        backgroundColor: CustomTheme.presentationButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.zero, // Eliminar padding adicional
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 120,
        width: 50, // Ajustar el ancho del botón para darle más espacio al ícono
        child: Center( // Centrar el ícono dentro del botón
          child: Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}