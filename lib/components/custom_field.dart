import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key, this.textEditingController, this.hintText, required this.labelText});
  final TextEditingController? textEditingController;
  final String? hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(labelText, style: const TextStyle(fontSize: 21),),
        ),
        TextField(
          textInputAction: TextInputAction.next,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.blue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}