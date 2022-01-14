import 'package:flutter/material.dart';
import '../extensions/extensions.dart';

class AppColors {
  AppColors._();

  static Color get primary => HexColor.fromHex('#E2AE5D');

  static Color get text => HexColor.fromHex('#333333');

  static Color get pink => HexColor.fromHex('#123464');

  static Color get lightBlue => HexColor.fromHex('#65D2E9');

  static Color get lightPink => HexColor.fromHex('#E6436D');

  static Color get white => HexColor.fromHex('#FFFFFF');

  static Color get black => HexColor.fromHex('#000000');

  static Color get grey => HexColor.fromHex('#86878B');


// static Color byTheme(BuildContext context, {required Color light, required Color dark}) =>
  //     AppThemeMode.of(context).isDark ? dark : light;
  //
  // static Color backgroundByTheme(BuildContext context, {Color? light, Color? dark}) =>
  //     AppThemeMode.of(context).isDark ? dark ?? text : light ?? Colors.white;
  //
  // static Color textByTheme(BuildContext context, {Color? light, Color? dark}) =>
  //     AppThemeMode.of(context).isDark ? dark ?? Colors.white : light ?? text;
}
