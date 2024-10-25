import 'dart:async';
import 'dart:io';
import 'package:pc_controller_master/components/main_button.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:pc_controller_master/api/connection_strings.dart';
import 'package:flutter/material.dart';

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
    final buttonWidth = mediaQuery.size.width * 0.3;

    void sendPrimaryClick() {
      socket.writeln("/primary_button");
    }

    void sendSecondaryClick() {
      socket.writeln("/secondary_button");
    }

    final buttons = [
      MagicPointerButton(width: buttonWidth, label: "Botón 1", function: sendPrimaryClick,),
      MagicPointerButton(width: buttonWidth, label: "Botón 2", function: sendSecondaryClick)
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Magic Pointer"),
          centerTitle: true,
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
            )
          ],
        )
    );
  }
}

class MagicPointerButton extends StatelessWidget {
  const MagicPointerButton({super.key, required this.width, this.label = "", this.function});
  final double width;
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
      function: function,
      primaryColor: Colors.blue, // Usa `primaryColor` en lugar de `primary`
      onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
      child: labelText,
    );
  }
}
