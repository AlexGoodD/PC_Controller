import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.textEditingController,
    this.hintText,
  });

  final TextEditingController? textEditingController;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        textInputAction: TextInputAction.next,
        controller: textEditingController,
        style: const TextStyle(
          color: CustomTheme.colorTextField,
          // Cambia el color del texto dentro del TextField
          fontSize: 15, // Ajusta el tamaño del texto si es necesario
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: CustomTheme.colorTextField, // Define el color del hintText
            fontSize: 15, // Ajusta el tamaño del hintText
          ),
          fillColor: CustomTheme.bgTextField,
          // Color de fondo
          filled: true,
          // Habilitar el color de fondo
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0.0, // Reducir relleno vertical para centrar el texto
            horizontal: 15.0, // Ajustar el relleno interno
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}