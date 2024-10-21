// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/circular_button.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/page_switcher.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/secoundary_buttons.dart';
import 'package:pc_controller_master/api/api.dart';
import 'package:pc_controller_master/api/connection_strings.dart';
import 'package:pc_controller_master/components/alerts.dart';

class SlideControlsScreen extends StatelessWidget {
  const SlideControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Controles de Presentación"),
    );

    void doCommand(String route) async {
      final token = await Api.sendBasicControl(route);
      switch (token) {

        case ResponseTypeToken.ok:
          break;
        case ResponseTypeToken.badRequest:
          errorAlert(context, "La petición no es válida", "Puede ser que está opción no este implementada en el servidor");
        case ResponseTypeToken.serverError:
          errorAlert(context, "El servidor no responde", "Revise el estado del servidor");
        case ResponseTypeToken.clientError:
          errorAlert(context, "Hubo un error de conexión", "Revise su conexión a internet o si la ip ingresada es válida");
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
          const SizedBox(height: 60,),
          SecondaryButtons(
            onNext: onNextElement,
            onPrev: onPrevElement,
          ),
          const SizedBox(height: 40,),
          CircularButton(
              icon: Icons.slideshow,
              onPressed: onSlideShowMode
          )
        ],
      ),
    );
  }
}