
import 'package:flutter/material.dart';

class custom_elevated_button extends StatelessWidget {
  final double? buttonWidth;
  final VoidCallback onPressed;
  final String text;
  const custom_elevated_button({
    super.key, this.buttonWidth, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: buttonWidth ?? MediaQuery.of(context).size.width - 100,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text,style: const TextStyle(
            color: Colors.white
          ),)
          ),
    );
  }
}