import 'package:flutter/material.dart';
import 'package:pc_controller_master/Screens/silde_controls/components/secondary_button.dart';

class SecondaryButtons extends StatelessWidget {
  const SecondaryButtons({super.key, required this.onPrev, required this.onNext});

  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SecondaryButton(text: "Retroceder", onPressed: onPrev,),
        SecondaryButton(text: "Avanzar", onPressed: onNext,)
      ],
    );
  }
}