import 'dart:ui';
import 'package:flutter/material.dart';

Future<void> showAlert(BuildContext context, Widget icon, String title, String message) async {
  return showDialog(context: context, builder: (context) {

    void closeAlert() {
      Navigator.of(context).pop();
    }

    TextButton okButton = TextButton(onPressed: closeAlert, child: const Text("Entendido"));

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        icon: icon,
        title: Text(title),
        content: Text(message),
        actions: [
          okButton
        ],
      ),
    );
  });
}

void successAlert(BuildContext context, String title, String message) async {
  const Icon icon = Icon(Icons.check);
  return await showAlert(context, icon, title, message);
}

void errorAlert(BuildContext context, String title, String message) async {
  const Icon icon = Icon(Icons.error);
  return await showAlert(context, icon, title, message);
}

void warningAlert(BuildContext context, String title, String message) async {
  const Icon icon = Icon(Icons.warning);
  return await showAlert(context, icon, title, message);
}