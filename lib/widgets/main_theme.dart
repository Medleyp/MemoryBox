import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memory_box/service/constants.dart';

final Widget hamburgerIcon =
    SvgPicture.asset('assets/icons/Menu.svg', height: 18);

const TextTheme textTheme = TextTheme(
  headline6: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 48,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  headline5: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 24,
    color: Constants.textColor,
    fontWeight: FontWeight.w500,
  ),
  headline4: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  ),
  headline3: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 18,
    color: Constants.textColor,
    fontWeight: FontWeight.w500,
  ),
  headline1: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 14,
    color: Constants.textColor,
    fontWeight: FontWeight.w500,
  ),
  subtitle1: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  ),
  subtitle2: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 16,
    color: Constants.textColor,
    fontWeight: FontWeight.normal,
  ),
  bodyText2: TextStyle(
    fontFamily: 'TTNorms',
    fontSize: 14,
    color: Constants.textColor,
    fontWeight: FontWeight.normal,
  ),
);

final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: const Color(0xFFF1B488),
    textStyle: const TextStyle(
      fontFamily: 'TTNorms',
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
);

final TextButtonThemeData textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    primary: const Color(0xFFF6F6F6),
    textStyle: TextStyle(
        color: const Color(0xFFF6F6F6),
        fontFamily: 'TTNorms',
        fontSize: 16,
        fontWeight: FontWeight.w500),
  ),
);
