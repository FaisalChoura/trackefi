import 'package:flutter/material.dart';

class TColors {
  static const mainGreen = Color(0xFF14CC60);
  static const mainGreen2 = Color(0xFF12BA58);
  static const accentGreen = Color(0xFF23FB67);
  static const gunmetal = Color(0xFF0A2E36);
  static const drakGreen = Color(0xFF036D19);

  static const Map<int, Color> color = {
    50: Color.fromRGBO(20, 204, 96, .1),
    100: Color.fromRGBO(20, 204, 96, .2),
    200: Color.fromRGBO(20, 204, 96, .3),
    300: Color.fromRGBO(20, 204, 96, .4),
    400: Color.fromRGBO(20, 204, 96, .5),
    500: Color.fromRGBO(20, 204, 96, .6),
    600: Color.fromRGBO(20, 204, 96, .7),
    700: Color.fromRGBO(20, 204, 96, .8),
    800: Color.fromRGBO(20, 204, 96, .9),
    900: Color.fromRGBO(20, 204, 96, 1),
  };

  static const MaterialColor materialGreen = MaterialColor(0xFF14CC60, color);
}

final lightTheme = ThemeData(
    primarySwatch: TColors.materialGreen,
    hoverColor: const Color(0x1A14CC60),
    splashColor: const Color(0x4014CC60),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    listTileTheme: const ListTileThemeData(
      selectedColor: Color(0xFF14CC60),
      iconColor: TColors.gunmetal,
      textColor: TColors.gunmetal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
          bottom: Radius.circular(12),
        ),
      ),
    ));
