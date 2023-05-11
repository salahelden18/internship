import 'package:flutter/material.dart';
import 'package:internship/core/global/colors.dart';
import 'package:internship/core/helpers/custom_route.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: CustomPageTransitionBuilder(),
    TargetPlatform.iOS: CustomPageTransitionBuilder(),
  }),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      size: 22,
      color: thirdColor,
    ),
  ),
  textTheme: TextTheme(
    // for main title
    titleLarge: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // for main screen subtitle
    titleMedium: TextStyle(
      fontSize: 24,
      color: Colors.black.withOpacity(0.5),
    ),
    // for job titles
    titleSmall: const TextStyle(
      fontSize: 18,
      letterSpacing: 5,
      color: Colors.black,
    ),
    headlineLarge: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: thirdColor,
    ),
    headlineMedium: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: const TextStyle(
      fontSize: 24,
      color: Colors.black54,
    ),
  ),
);
