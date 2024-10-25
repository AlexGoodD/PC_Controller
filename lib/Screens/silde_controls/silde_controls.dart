// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/circular_button.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/page_switcher.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/secoundary_buttons.dart';
import 'package:pc_controller_master/api/api.dart';
import 'package:pc_controller_master/api/connection_strings.dart';
import 'package:pc_controller_master/components/alerts.dart';
import 'package:pc_controller_master/settings/theme.dart';

class SlideControlsScreen extends StatelessWidget {
  const SlideControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      preferredSize: const Size.fromHeight(80), // Ajustar la altura total del AppBar si lo deseas
      child: Column(
        children: [
          const SizedBox(height: 20), // Espacio adicional en la parte superior del AppBar
          AppBar(
            backgroundColor: Colors.transparent, // Hacer el fondo transparente
            elevation: 0, // Quitar la sombra
            leading: Padding(
              padding: const EdgeInsets.all(10.0), // Espacio alrededor del botón
              child: SizedBox(
                width: 30, // Hacer el botón cuadrado
                height: 30, // Hacer el botón cuadrado
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Remover padding interno
                    backgroundColor: CustomTheme.bgTextField, // Color de fondo del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Bordes redondeados, pero cuadrado
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Acción para ir atrás
                  },
                  child: const Icon(Icons.arrow_back, color: CustomTheme.colorTextField), // Ícono de flecha hacia atrás
                ),
              ),
            ),
            title: const Text(
              "Controles de presentación",
              style: TextStyle(
                color: Colors.white, // Cambia el color del texto
                fontWeight: FontWeight.bold, // Ajusta el peso del texto si lo deseas
              ),
            ),
            centerTitle: true,
          ),
        ],
      ),
    );

    void doCommand(String route) async {
      final token = await Api.sendBasicControl(route);
      switch (token) {
        case ResponseTypeToken.ok:
          break;
        case ResponseTypeToken.badRequest:
          errorAlert(context, "La petición no es válida", "Puede ser que esta opción no esté implementada en el servidor");
        case ResponseTypeToken.serverError:
          errorAlert(context, "El servidor no responde", "Revise el estado del servidor");
        case ResponseTypeToken.clientError:
          errorAlert(context, "Hubo un error de conexión", "Revise su conexión a internet o si la IP ingresada es válida");
          break;
      }
    }

    void nextSlide() async {
      doCommand(ConnectionStrings.nextSlideUrl());
    }

    void prevSlide() {
      doCommand(ConnectionStrings.prevSlideUrl());
    }

    void onNextElement() {
      doCommand(ConnectionStrings.nextItemSlideUrl());
    }

    void onPrevElement() {
      doCommand(ConnectionStrings.prevItemSlideUrl());
    }

    void onSlideShowMode() {
      doCommand(ConnectionStrings.switchModeSlide());
    }

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageSwitcher(
            nextSlideAction: nextSlide,
            prevSlideAction: prevSlide,
          ),
          const SizedBox(height: 60),
          SecondaryButtons(
            onNext: onNextElement,
            onPrev: onPrevElement,
          ),
          const SizedBox(height: 100),
          CircularButton(
            icon: Icons.slideshow,
            onPressed: onSlideShowMode,
          ),
        ],
      ),
    );
  }
}