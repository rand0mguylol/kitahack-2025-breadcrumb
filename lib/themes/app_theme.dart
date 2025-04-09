import 'package:flutter/material.dart';
import 'package:breadcrumbs/themes/app_bar_theme.dart';
import 'package:breadcrumbs/themes/nav_bar_theme.dart';

import 'package:breadcrumbs/themes/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData appTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color.fromRGBO(232, 234, 240, 1),
      primaryColor: Colors.black,
      textTheme: AppTextTheme.textTheme,
      appBarTheme: CustomAppBarTheme.navTheme,
      navigationBarTheme: NavBarTheme.navBarTheme);
}
