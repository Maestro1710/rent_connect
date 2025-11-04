import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;

  const LogoWidget({
    this.fontSize = 32,
    this.color,
    this.fontWeight = FontWeight.bold,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "RENT CONNECT",
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).colorScheme.primary,
        letterSpacing: 1.2,
      ),
    );
  }
}
