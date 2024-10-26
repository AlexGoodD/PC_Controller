import 'package:flutter/material.dart';
import 'package:pc_controller_master/api/api.dart';
import 'package:pc_controller_master/components/alerts.dart';
import 'package:pc_controller_master/components/custom_field.dart';
import 'package:pc_controller_master/components/main_button.dart';
import 'package:pc_controller_master/api/connection_strings.dart';
import 'package:pc_controller_master/settings/theme.dart';

class VideoControl extends StatelessWidget {
  const VideoControl({super.key});

  static TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const horizontalGap = Padding(padding: EdgeInsets.symmetric(horizontal: 4));
    const verticalGap = Padding(padding: EdgeInsets.symmetric(vertical: 8));

    void sendGenericClientError() {
      errorAlert(context, "No se pudo enviar la petición", "Revise que tenga conexión a internet o que la dirección IP sea válida");
    }

    void sendGenericServerError() {
      errorAlert(context, "Hubo un problema", "El servidor parece haber tenido un problema interno");
    }

    void sendBadRequestError() {
      errorAlert(context, "La petición fue rechazada por el servidor", "Esta petición parece ser que no es válida");
    }

    void sendBasicCommand(String connectionString) async {
      final token = await Api.sendBasicControl(connectionString);
      switch (token) {
        case ResponseTypeToken.serverError:
          sendGenericServerError();
          break;
        case ResponseTypeToken.badRequest:
          sendBadRequestError();
          break;
        case ResponseTypeToken.clientError:
          sendGenericClientError();
          break;
        case ResponseTypeToken.ok:
          break;
      }
    }

    void playPause() async {
      sendBasicCommand(ConnectionStrings.toggleVideoPlayPauseApiUrl());
    }

    void advance() async {
      sendBasicCommand(ConnectionStrings.forwardVideoApiUrl());
    }

    void goBack() async {
      sendBasicCommand(ConnectionStrings.rewindVideoApiUrl());
    }

    void goNext() async {
      sendBasicCommand(ConnectionStrings.nextTrackApiUrl());
    }

    void goPrev() async {
      sendBasicCommand(ConnectionStrings.prevTrackApiUrl());
    }

    void goEnter() async {
      sendBasicCommand(ConnectionStrings.enterApiUrl());
    }

    void usingLB() async {
      sendBasicCommand(ConnectionStrings.lbApiUrl());
    }

    void usingRB() async {
      sendBasicCommand(ConnectionStrings.rbApiUrl());
    }

    void goFullScreen() async {
      sendBasicCommand(ConnectionStrings.toggleFullscreenVideoApiUrl());
    }

    void volumeUp() async {
      sendBasicCommand(ConnectionStrings.setVolumeUpApiUrl());
    }

    void volumeMute() async {
      sendBasicCommand(ConnectionStrings.setVolumeMuteApiUrl());
    }

    void volumeDown() async {
      sendBasicCommand(ConnectionStrings.setVolumeDownApiUrl());
    }

    void sendText() async {
      var data = {"fromUser": "AndroidDevice", "query": textController.text};
      final token = await Api.sendComplexCommand(ConnectionStrings.getTypeApiUrl(), data);

      switch (token) {
        case ResponseTypeToken.badRequest:
          sendBadRequestError();
          break;
        case ResponseTypeToken.serverError:
          sendGenericServerError();
          break;
        case ResponseTypeToken.clientError:
          sendGenericClientError();
          break;
        case ResponseTypeToken.ok:
          textController.text = "";
          break;
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Ajustar la altura total del AppBar
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
                "Controles de vídeo",
                style: TextStyle(
                  color: Colors.white, // Cambia el color del texto
                  fontWeight: FontWeight.bold, // Ajusta el peso del texto si lo deseas
                ),
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start, // Alinear al inicio de la columna
          children: [
            //const SizedBox(height: 10), // Espacio en la parte superior
            // Label para el TextField
            const Padding(
              padding: EdgeInsets.only(right: 100), // Ajuste para alinear mejor el label
              child: Text(
                "Ingresa una búsqueda:",
                style: TextStyle(
                  fontSize: 22,
                  color: CustomTheme.primaryFontColor, // Color del label
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10), // Espacio entre el label y el campo de texto
            Row(
              children: [
                Expanded(
                  child: CustomField(
                    hintText: 'Ej. "Vídeos de perros recompilación"',
                    textEditingController: textController,
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre el TextField y el botón
                SizedBox(
                  width: 40, // Tamaño cuadrado para el botón
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // Remover padding interno
                      backgroundColor: CustomTheme.videoButton, // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordes redondeados pero cuadrados
                      ),
                    ),
                    onPressed: sendText, // Acción para enviar texto
                    child: const Icon(Icons.send, color: Colors.white), // Ícono de enviar
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60), // Espacio entre la primera fila y los botones de abajo
            // Segunda fila con botones de acciones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: goFullScreen,
                  shape: const CircleBorder(),
                  backgroundColor: CustomTheme.videoButton,
                  child: const Icon(Icons.fullscreen_rounded, color: CustomTheme.primaryFontColor),
                ),
                const SizedBox(width: 220), // Espacio entre los botones
                FloatingActionButton(
                  onPressed: volumeMute,
                  shape: const CircleBorder(),
                  backgroundColor: CustomTheme.videoButton,
                  child: const Icon(Icons.volume_off, color: CustomTheme.primaryFontColor),
                ),
              ],
            ),
            const SizedBox(height: 15), // Espacio adicional entre las filas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: goNext,
                      shape: const CircleBorder(),
                      backgroundColor: CustomTheme.videoButton,
                      child: const Icon(Icons.skip_next, color: CustomTheme.primaryFontColor),
                    ),
                    const SizedBox(height: 15), // Espacio entre los botones en la columna
                    FloatingActionButton(
                      onPressed: goPrev,
                      shape: const CircleBorder(),
                      backgroundColor: CustomTheme.videoButton,
                      child: const Icon(Icons.skip_previous, color: CustomTheme.primaryFontColor),
                    )
                  ],
                ),
                const SizedBox(width: 20), // Espacio entre columnas
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: MainButton(
                        width: 50,
                        height: 50,
                        function: goEnter,
                        primaryColor: CustomTheme.videoButton, // Usa `primaryColor` en lugar de `primary`
                        onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
                        child: const CustomTextButton(text: "Enter")),
                  ),
                ),
                const SizedBox(width: 20), // Espacio entre columnas
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: volumeDown,
                      shape: const CircleBorder(),
                      backgroundColor: CustomTheme.videoButton,
                      child: const Icon(Icons.volume_down, color: CustomTheme.primaryFontColor),
                    ),
                    const SizedBox(height: 15), // Espacio entre los botones en la columna
                    FloatingActionButton(
                      onPressed: volumeUp,
                      shape: const CircleBorder(),
                      backgroundColor: CustomTheme.videoButton,
                      child: const Icon(Icons.volume_up, color: CustomTheme.primaryFontColor),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 100), // Espacio adicional entre las filas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  width: 48,
                  height: 50,
                  function: goBack,
                  primaryColor: CustomTheme.videoButton,
                  onPrimaryColor: Colors.white,
                  child: const Icon(Icons.fast_rewind),
                ),
                const SizedBox(width: 20), // Espacio entre los botones
                MainButton(
                  width: 48,
                  height: 50,
                  function: playPause,
                  primaryColor: CustomTheme.videoButton,
                  onPrimaryColor: Colors.white,
                  child: const Icon(Icons.play_arrow),
                ),
                const SizedBox(width: 20), // Espacio entre los botones
                MainButton(
                  width: 48,
                  height: 50,
                  function: advance,
                  primaryColor: CustomTheme.videoButton,
                  onPrimaryColor: Colors.white,
                  child: const Icon(Icons.fast_forward),
                )
              ],
            ),
            const SizedBox(height: 20), // Espacio adicional entre las filas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  width: 64,
                  height: 50,
                  function: usingLB,
                  primaryColor: CustomTheme.videoButton,
                  onPrimaryColor: Colors.white,
                  child: const CustomTextButton(text: "LB"),
                ),
                const SizedBox(width: 20), // Espacio entre los botones
                MainButton(
                  width: 64,
                  height: 50,
                  function: usingRB,
                  primaryColor: CustomTheme.videoButton,
                  onPrimaryColor: Colors.white,
                  child: const CustomTextButton(
                    text: "RB",
                  ),
                )
              ],
            ),
            const Expanded(child: Column())
          ],
        ),
      ),
    );
  }
}