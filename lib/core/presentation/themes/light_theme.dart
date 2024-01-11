import 'package:flutter/material.dart';

class TColors {
  static const main = Color(0xFF2981F5);
  static const accent = Color(0xFF2981F5);
  static const hover = Color(0x1A3C8DF6);
  static const splash = Color(0x403C8DF6);
  static const gunmetal = Color(0xFF0A2E36);
  static const silver = Color(0xFFF5F5F5);
  static const labelColor = Color.fromRGBO(41, 128, 245, 0.275);

  static const blue = Color(0xFF2981F5);

  static const grey = Color(0xFFB8B8B8);
  static const lightGrey = Color(0xFFEFEFEF);

  static const lightBlue = Color(0x482981F5);
  static const lightRed = Color(0x48E14414);
  static const red = Color(0xFFC1292E);
  static const red2 = Color(0xFFD62839);

  static const Map<int, Color> color = {
    50: Color.fromRGBO(41, 128, 245, .1),
    100: Color.fromRGBO(41, 128, 245, .2),
    200: Color.fromRGBO(41, 128, 245, .3),
    300: Color.fromRGBO(41, 128, 245, .4),
    400: Color.fromRGBO(41, 128, 245, .5),
    500: Color.fromRGBO(41, 128, 245, .6),
    600: Color.fromRGBO(41, 128, 245, .7),
    700: Color.fromRGBO(41, 128, 245, .8),
    800: Color.fromRGBO(41, 128, 245, .9),
    900: Color.fromRGBO(41, 128, 245, 1),
  };

  static const MaterialColor materialBlue = MaterialColor(0xFF2981F5, color);
}

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: TColors.materialBlue,
    dialogBackgroundColor: Colors.white,
    dividerColor: TColors.grey,
    hoverColor: TColors.hover,
    splashColor: TColors.splash,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    listTileTheme: const ListTileThemeData(
      selectedColor: Color(0xFF3C8DF6),
      iconColor: TColors.gunmetal,
      textColor: TColors.gunmetal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
          bottom: Radius.circular(12),
        ),
      ),
    ));
