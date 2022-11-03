import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final Color? color;
  final String text;

  final dynamic onPressed; //TODO fix type annotation

  const RoundedButtonWidget(
      {this.color, required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor, //TODO Fix color selections
        shape: const StadiumBorder(),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
