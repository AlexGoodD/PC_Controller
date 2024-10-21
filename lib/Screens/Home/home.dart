import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/Home/components/main_home.dart';
import 'package:pc_controller_master/Screens/Home/components/main_title.dart';
import 'package:pc_controller_master/Screens/Home/components/nav_to_button.dart';
import 'package:pc_controller_master/Screens/SendPage/send_page.dart';
import 'package:pc_controller_master/Screens/host_name_screen/host_name_screen.dart';
import 'package:pc_controller_master/Screens/magic_pointer_screen/magic_pointer_screen.dart';
import 'package:pc_controller_master/Screens/silde_controls/silde_controls.dart';
import 'package:pc_controller_master/Screens/video_controls/video_controls.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void changeHostname() async {

      final mediaQ = MediaQuery.of(context);
      final width = mediaQ.size.width;

      await showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            width: width,
            child: const HostNameScreen(),
          ));
    }

    void navigateToSendWebPage() {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SendPage())
      );
    }

    void navigateToVideoControls() {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideoControl())
      );
    }

    void navigateToSlideShowControls() {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SlideControlsScreen())
      );
    }

    void navigateToMagicPointerScreen() {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MagicPointerScreen())
      );
    }

    final List<NavToButton> buttons = [
      NavToButton(
          value: "Modificar Hostname",
          onPress: changeHostname
      ),
      NavToButton(
          value: "Abrir una página Web",
          onPress: navigateToSendWebPage
      ),
      NavToButton(
          value: "Controles de vídeo",
          onPress: navigateToVideoControls
      ),
      NavToButton(
          value: "Controles de presentación",
          onPress: navigateToSlideShowControls
      ),
      NavToButton(
          value: "Usar Puntero Mágico",
          onPress: navigateToMagicPointerScreen
      )
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("My PC controller"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MainTitle(value: "Seleccione una de las opciones"),
            const MainHomeArt(),
            const Expanded(child: Column()),
            ...buttons
          ],
        ));
  }
}
