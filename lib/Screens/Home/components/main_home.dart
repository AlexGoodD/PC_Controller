import 'package:flutter/material.dart';

class MainHomeArt extends StatelessWidget {
  const MainHomeArt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    const double width = 300;
    const double height = 300;

    return SizedBox(
      width: width,
      height: height,
        child: Image.asset(
          "assets/images/wirelessicon.png",
        ),
    );
  }
}