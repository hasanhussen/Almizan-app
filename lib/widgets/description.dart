import 'package:flutter/material.dart';
import 'package:almizan/general/constant.dart';

class Description extends StatelessWidget {
  final String text;
  final double fontSize;

  const Description({
    Key? key,
    required this.text,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
