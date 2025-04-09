import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required String text,
      Color? backgroundColor,
      Color? textColor,
      VoidCallback? onPressed})
      : _onPressed = onPressed ?? (() {}),
        _text = text,
        _backgroundColor =
            backgroundColor ?? const Color.fromRGBO(97, 0, 255, 1),
        _textColor = textColor ?? Colors.white;

  final VoidCallback _onPressed;
  final String _text;
  final Color _backgroundColor;
  final Color _textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ButtonStyle(
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12.0)),
          backgroundColor: WidgetStateProperty.all(_backgroundColor)),
      child: Text(_text, style: TextStyle(color: _textColor)),
    );
  }
}
