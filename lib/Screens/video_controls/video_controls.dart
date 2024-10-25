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
      appBar: AppBar(
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
        title: const Text("Controles de vídeo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomField(
                    hintText: "Ej. Vídeos de perros",
                    textEditingController: textController,
                  ),
                ),
                const SizedBox(width: 8), // Espacio entre el TextField y el botón
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
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: goFullScreen,
                  shape: const CircleBorder(),
                  backgroundColor: CustomTheme.videoButton,
                  child: const Icon(Icons.fullscreen_rounded, color: CustomTheme.primaryFontColor),
                ),
                const Expanded(child: Row()),
                FloatingActionButton(
                  onPressed: volumeMute,
                  shape: const CircleBorder(),
                  backgroundColor: CustomTheme.videoButton,
                  child: const Icon(Icons.volume_off, color: CustomTheme.primaryFontColor),
                ),
              ],
            ),
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
                    verticalGap,
                    FloatingActionButton(
                      onPressed: goPrev,
                      shape: const CircleBorder(),
                      backgroundColor: CustomTheme.videoButton,
                      child: const Icon(Icons.skip_previous, color: CustomTheme.primaryFontColor),
                    )
                  ],
                ),
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
                    )),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: volumeDown,
                      shape: const CircleBorder(),
                      backgroundColor: CustomTheme.videoButton,
                      child: const Icon(Icons.volume_down, color: CustomTheme.primaryFontColor),
                    ),
                    verticalGap,
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
            verticalGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  width: 48,
                  height: 50,
                  function: goBack,
                  primaryColor: CustomTheme.videoButton, // Usa `primaryColor` en lugar de `primary`
                  onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
                  child: const Icon(Icons.fast_rewind),
                ),
                horizontalGap,
                MainButton(
                  width: 48,
                  height: 50,
                  function: playPause,
                  primaryColor: CustomTheme.videoButton, // Usa `primaryColor` en lugar de `primary`
                  onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
                  child: const Icon(Icons.play_arrow),
                ),
                horizontalGap,
                MainButton(
                  width: 48,
                  height: 50,
                  function: advance,
                  primaryColor: CustomTheme.videoButton, // Usa `primaryColor` en lugar de `primary`
                  onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
                  child: const Icon(Icons.fast_forward),
                )
              ],
            ),
            verticalGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  width: 64,
                  height: 50,
                  function: usingLB,
                  primaryColor: CustomTheme.videoButton, // Usa `primaryColor` en lugar de `primary`
                  onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
                  child: const CustomTextButton(text: "LB"),
                ),
                horizontalGap,
                MainButton(
                  width: 64,
                  height: 50,
                  function: usingRB,
                  primaryColor: CustomTheme.videoButton, // Usa `primaryColor` en lugar de `primary`
                  onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
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