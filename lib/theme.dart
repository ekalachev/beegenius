import 'package:flutter/material.dart';
import 'helpers.dart';

mixin ThemeColors {
  static final MaterialColor themeColor =
      Helpers.createMaterialColor(const Color(0xff0a4f51));
  static final MaterialColor themeBackgroundColor =
      Helpers.createMaterialColor(const Color(0xffEDE091));
  static final MaterialColor textColor =
      Helpers.createMaterialColor(const Color(0xffEDE091));
}

mixin ThemeImages {
  static final Image logo = Image.asset(
    'assets/ios_logo.png',
    filterQuality: FilterQuality.high,
  );
}
