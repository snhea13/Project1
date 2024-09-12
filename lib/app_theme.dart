import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color grey = Colors.grey;
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Colors.white;
  static const Color nearlyBlack = Color(0xFF213333);
  //static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    displayLarge: display1,  // Corresponds to h4 -> display1
    displayMedium: headline,  // Corresponds to h5 -> headline
    displaySmall: title,     // Corresponds to h6 -> title
    titleMedium: subtitle,  // Corresponds to subtitle2 -> subtitle
    bodyLarge: body1,     // Corresponds to body1 -> bodyText1
    bodyMedium: body2,     // Corresponds to body2 -> bodyText2
    labelSmall: caption,     // Same in both versions
    labelLarge: button,       // Optional
    //overline: overline,   // Optional
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 1.25,
    color: white,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    letterSpacing: 1.5,
    color: darkText,
  );
}
