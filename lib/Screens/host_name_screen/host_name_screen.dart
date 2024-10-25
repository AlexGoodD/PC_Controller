import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pc_controller_master/components/custom_field.dart';
import 'package:pc_controller_master/components/main_button.dart';
import 'package:pc_controller_master/api/connection_strings.dart';

class HostNameScreen extends StatelessWidget {
  const HostNameScreen({super.key});

  static TextEditingController hostnameLabel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const verticalGap = Padding(padding: EdgeInsets.symmetric(vertical: 8));

    void changeHostname() {
      ConnectionStrings.setHostName(hostnameLabel.text);
      Navigator.of(context).pop();
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2, tileMode: TileMode.decal),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Cambiar hostname",
                style: TextStyle(fontSize: 21),
              ),
            ),
            const Divider(),
            CustomField(
              //labelText: "Ingrese el hostname:",
              hintText: "EJ. 127.0.0.1",
              textEditingController: hostnameLabel,
            ),
            verticalGap,
            MainButton(
              width: MediaQuery.of(context).size.width,
              function: changeHostname,
              primaryColor: Colors.blue, // Usa `primaryColor` en lugar de `primary`
              onPrimaryColor: Colors.white, // Usa `onPrimaryColor` en lugar de `onPrimary`
              child: const CustomTextButton(text: "Aplicar cambios"),
            )
          ],
        ),
      ),
    );
  }
}
