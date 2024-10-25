import 'dart:async';
import 'dart:io';
import 'package:pc_controller_master/components/main_button.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:pc_controller_master/api/connection_strings.dart';
import 'package:flutter/material.dart';
import 'package:pc_controller_master/settings/theme.dart';

class GyroPosition {
  double x;
  double y;
  double z;

  GyroPosition(this.x, this.y, this.z);

  void setPosition(double xPos, double yPos, double zPos) {
    x = xPos;
    y = yPos;
    z = zPos;
  }

  @override
  String toString() {
    return "{x:$x} {y:$y} {z:$z}";
  }
}

class MagicPointerScreen extends StatefulWidget {
  const MagicPointerScreen({super.key});

  @override
  State<MagicPointerScreen> createState() => _MagicPointerScreenState();
}

class _MagicPointerScreenState extends State<MagicPointerScreen> {
  final Uri wsUri = Uri.parse(ConnectionStrings.getMouseSocketApiUrl());
  late StreamSubscription<AccelerometerEvent> accEvent;
  late StreamSubscription channelSubscription;

  final GyroPosition current = GyroPosition(0, 0, 0);

  late Socket socket;

  void setListener() async {
    socket = await Socket.connect(ConnectionStrings.serverHostname,
        ConnectionStrings.mouseTrackerPort);

    accEvent = accelerometerEvents.listen((event) {
      current.setPosition(event.x, event.y, event.z);
      socket.writeln("/set_pos ${current.toString()}");
    });
  }

  @override
  void initState() {
    super.initState();
    setListener();
  }

  @override
  void dispose() {
    accEvent.cancel();
    socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const verticalPaddingValue = 16.0;

    final mediaQuery = MediaQuery.of(context);

    void sendPrimaryClick() {
      socket.writeln("/primary_button");
    }

    void sendSecondaryClick() {
      socket.writeln("/secondary_button");
    }

    final buttons = [
      MagicPointerButton(width: 100, height: 50, label: "Botón 1", function: sendPrimaryClick,),
      MagicPointerButton(width: 100, height: 50, label: "Botón 2", function: sendSecondaryClick)
    ];

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
                  "Puntero mágico",
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
        body: Column(
          children: [
            const Expanded(child: Column()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: verticalPaddingValue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: buttons,
              ),
            ),
            const SizedBox(height: 100), // Espacio adicional debajo de los botones
          ],
        )
    );
  }
}

class MagicPointerButton extends StatelessWidget {
  const MagicPointerButton({super.key, required this.width, this.label = "", this.function, required this.height});
  final double width;
  final double height;
  final String label;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    final labelText = Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
    );
    return MainButton(
      width: width,
      height: height,
      function: function,
      primaryColor: CustomTheme.cursorButton, // Usa `primaryColor` en lugar de `primary`
      onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
      child: labelText,
    );
  }
}