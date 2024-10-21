import 'package:flutter/material.dart';
import 'package:pc_controller_master/api/api.dart';
import 'package:pc_controller_master/components/alerts.dart';
import 'package:pc_controller_master/components/custom_field.dart';
import 'package:pc_controller_master/components/main_button.dart';
import 'package:pc_controller_master/api/connection_strings.dart';

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
        title: const Text("Controles de Vídeo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomField(
              labelText: "Envía un texto: ",
              hintText: "Ej. Vídeos de perros",
              textEditingController: textController,
            ),
            verticalGap,
            MainButton(
              width: double.maxFinite,
              function: sendText,
              child: const CustomTextButton(
                text: "Enviar texto",
              ),
            ),
            const Expanded(
              child: Column(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: goFullScreen,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.fullscreen_rounded),
                ),
                const Expanded(child: Row()),
                FloatingActionButton(
                  onPressed: volumeMute,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.volume_mute),
                ),
              ],
            ),
            verticalGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: goNext,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.skip_next),
                    ),
                    verticalGap,
                    FloatingActionButton(
                      onPressed: goPrev,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.skip_previous),
                    )
                  ],
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: MainButton(
                          width: double.maxFinite,
                          function: goEnter,
                          child: const CustomTextButton(text: "Enter")),
                    )),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: volumeUp,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.volume_up),
                    ),
                    verticalGap,
                    FloatingActionButton(
                      onPressed: volumeDown,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.volume_down),
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
                  function: goBack,
                  child: const Icon(Icons.fast_rewind),
                ),
                horizontalGap,
                MainButton(
                  width: 48,
                  function: playPause,
                  child: const Icon(Icons.play_arrow),
                ),
                horizontalGap,
                MainButton(
                  width: 48,
                  function: advance,
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
                  function: usingLB,
                  child: const CustomTextButton(text: "LB"),
                ),
                horizontalGap,
                MainButton(
                  width: 64,
                  function: usingRB,
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