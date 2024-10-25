import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/Home/components/main_home.dart';
import 'package:pc_controller_master/Screens/Home/components/main_title.dart'; //eliminada
import 'package:pc_controller_master/Screens/Home/components/nav_to_button.dart';
//import 'package:pc_controller_master/Screens/SendPage/send_page.dart'; Cambiada por sendwebbottomsheet
import 'package:pc_controller_master/Screens/magic_pointer_screen/magic_pointer_screen.dart';
import 'package:pc_controller_master/Screens/silde_controls/silde_controls.dart';
import 'package:pc_controller_master/Screens/video_controls/video_controls.dart';
import 'package:pc_controller_master/settings/theme.dart';
import 'package:pc_controller_master/components/custom_field.dart';
//import 'package:pc_controller_master/components/main_button.dart';
import 'package:pc_controller_master/api/connection_strings.dart';
import 'package:pc_controller_master/Screens/SendPage/SendWebBottomSheet.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static TextEditingController hostnameLabel = TextEditingController();

  void changeHostname(BuildContext context) {
    ConnectionStrings.setHostName(hostnameLabel.text);
    // Mostrar mensaje o hacer alguna acción si lo necesitas.
  }

  @override
  Widget build(BuildContext context) {
    void navigateToSendWebPage(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Permite que el Bottom Sheet se expanda según el contenido
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return const SendWebBottomSheet(); // El nuevo widget que crearemos
        },
      );
    }

    void navigateToVideoControls() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const VideoControl()));
    }

    void navigateToSlideShowControls() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SlideControlsScreen()));
    }

    void navigateToMagicPointerScreen() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MagicPointerScreen()));
    }

    final List<NavToButton> buttons = [
      NavToButton(
        value: "Ingresar a página web",
        onPress: () => navigateToSendWebPage(context), // Llama al método con `context`
        buttonColor: CustomTheme.webButton,
        icon: Icons.language, // Ícono para este botón
      ),
      NavToButton(
        value: "Controles de vídeo",
        onPress: navigateToVideoControls,
        buttonColor: CustomTheme.videoButton,
        icon: Icons.videocam_outlined, // Ícono para este botón
      ),
      NavToButton(
        value: "Controles de presentación",
        onPress: navigateToSlideShowControls,
        buttonColor: CustomTheme.presentationButton,
        icon: Icons.co_present_outlined, // Ícono para este botón
      ),
      NavToButton(
        value: "Puntero mágico",
        onPress: navigateToMagicPointerScreen,
        buttonColor: CustomTheme.cursorButton,
        icon: Icons.mouse_outlined, // Ícono para este botón
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50), // Reducir espacio inicial si es necesario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0), // Reducir padding vertical
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end, // Centrar los elementos verticalmente
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ingrese el Hostname:", // Texto manual sobre el CustomField
                          style: TextStyle(
                            fontSize: 22,
                            color: CustomTheme.primaryFontColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5), // Espacio entre el texto y el CustomField
                        CustomField(
                          hintText: "Ej. 127.0.0.1",
                          textEditingController: hostnameLabel,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10), // Espacio entre el campo y el botón
                  SizedBox(
                    width: 40, // Hacer el botón cuadrado
                    height: 40, // Hacer el botón cuadrado
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remover el padding para centrar el ícono
                        backgroundColor: Colors.blue, // Color del fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bordes redondeados
                        ),
                      ),
                      onPressed: () => changeHostname(context),
                      child: const Icon(Icons.check, size: 24, color: Colors.white,), // Ícono de check centrado
                    ),
                  ),
                ],
              ),
            ),
            const MainHomeArt(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0), // Remover padding vertical
              child: Wrap(
                spacing: 40, // Espacio horizontal entre botones
                runSpacing: 4, // Espacio vertical entre botones
                alignment: WrapAlignment.center, // Centra los botones en la pantalla
                children: buttons.map((button) {
                  return SizedBox(
                    width: 150, // Ancho fijo para que se vea en formato de cuadrícula
                    height: 150, // Altura fija para los botones
                    child: button,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}