import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton(
      {super.key,
      required this.text,
      required this.clicked,
      this.overlayColorValue,
      this.backgroundColorValue,
      this.defaultBackgroundColor});

  final String text;
  final Function() clicked;
  final MaterialStateProperty<Color?>? overlayColorValue;
  final MaterialStateProperty<Color?>? backgroundColorValue;
  final MaterialStateProperty<Color?>? defaultBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: clicked,
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll<Size>(Size(0, 42)),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        overlayColor: overlayColorValue,
        backgroundColor: backgroundColorValue,
      ),
      child: Text(text),
    );
  }
}
