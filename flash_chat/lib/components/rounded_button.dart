import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.color,
      required this.textColor,
      required this.buttonText,
      required this.onPressed,
      this.borderRadius = 5.0,
      Key? key})
      : super(key: key);

  final Color color;
  final Color textColor;
  final Function onPressed;
  final String buttonText;

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
