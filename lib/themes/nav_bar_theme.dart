import 'package:flutter/material.dart';

class NavBarTheme {
  NavBarTheme._();

  static NavigationBarThemeData navBarTheme = NavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      indicatorColor: Colors.white,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
      height: 65);
}
