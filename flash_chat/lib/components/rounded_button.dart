import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.color,
      required this.textColor,
      required this.buttonText,
      required this.onPressed,
      this.borderRadius = 5.0,
      this.horizontalPadding = 20,
      this.verticalPadding = 10,
      Key? key})
      : super(key: key);

  final Color color;
  final Color textColor;
  final Function onPressed;
  final String buttonText;

  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
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
