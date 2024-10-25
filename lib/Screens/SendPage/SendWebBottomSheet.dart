import 'package:flutter/material.dart';
import 'package:pc_controller_master/api/api.dart';
import 'package:pc_controller_master/components/custom_field.dart';
import 'package:pc_controller_master/components/main_button.dart';
import 'package:pc_controller_master/components/alerts.dart';
import 'package:pc_controller_master/settings/theme.dart';

class SendWebBottomSheet extends StatelessWidget {
  const SendWebBottomSheet({super.key});

  static final textEditingController = TextEditingController();

  void sendUrl(BuildContext context) async {
    switch (await Api.sendUrl(textEditingController.text)) {
      case ResponseTypeToken.ok:
        textEditingController.text = "";
        Navigator.of(context).pop();
        break;
      case ResponseTypeToken.serverError:
        errorAlert(context, "No se pudo enviar", "El servidor tuvó un problema interno");
        break;
      case ResponseTypeToken.badRequest:
        errorAlert(context, "No se pudo enviar", "El servidor no reconoce esta petición");
        break;
      case ResponseTypeToken.clientError:
        errorAlert(context, "No se pudo enviar", "Revise que su conexión sea estable o si la dirección IP es válida");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Ajusta para el teclado
        left: 0,
        right: 0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), // Bordes superiores redondeados
        child: Container(
          color: CustomTheme.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajustar al contenido mínimo
            children: [
              // AppBar personalizado
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                color: CustomTheme.webButton,
                child: Row(
                  children: [
                    const Icon(Icons.language, color: Colors.white, size: 35,), // Ícono a la izquierda
                    const SizedBox(width: 30), // Espacio entre el ícono y el texto
                    const Text(
                      "Ingresar a página web",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Campo de texto y botón en la misma línea
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomField(
                        //labelText: "Ingresa una URL:",
                        hintText: "Ej. https://www.youtube.com/",
                        textEditingController: textEditingController,
                      ),
                    ),
                    const SizedBox(width: 10), // Espacio entre el campo y el botón
                    IconButton(
                      onPressed: () => sendUrl(context),
                      icon: const Icon(Icons.send, color: CustomTheme.webButton),
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}