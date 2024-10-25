import 'package:flutter/material.dart';
import 'package:pc_controller_master/components/main_button.dart';

class NavToButton extends StatelessWidget {
  const NavToButton({
    super.key,
    required this.value,
    required this.onPress,
    required this.buttonColor,
    required this.icon, // Nuevo parámetro para el ícono
  });

  final String value;
  final VoidCallback onPress;
  final Color buttonColor;
  final IconData icon; // Tipo de dato para el ícono

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
      child: MainButton(
        width: MediaQuery.of(context).size.width * 0.8,
        primaryColor: buttonColor,
        onPrimaryColor: Colors.white,
        function: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar contenido verticalmente
          children: [
            Icon(icon, color: Colors.white, size: 35), // Ícono centrado
            const SizedBox(height: 5), // Espacio entre el ícono y el texto
            Text(
              value,
              textAlign: TextAlign.center, // Centrar el texto
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}