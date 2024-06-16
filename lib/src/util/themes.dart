import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glossll/src/util/constants.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: GlossLlColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.black,
      selectionColor: Colors.black12,
      cursorColor: Colors.black,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
          ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade100,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}

ThemeData buildDarkThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: GlossLlColors.primaryColor,
    scaffoldBackgroundColor: Colors.grey.shade800,
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.white,
      selectionColor: Colors.white12,
      cursorColor: Colors.white,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
          ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade500,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
