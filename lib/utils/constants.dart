import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromRGBO(237, 27, 36, 1.0);
const COLOR_SECONDARY = Color.fromRGBO(118, 181, 197, 1.0);
const COLOR_BLACK = Colors.black;
const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);
const COLOR_WHITE = Colors.white;

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 26),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    bodyText1: TextStyle(
        color: COLOR_BLACK, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_BLACK, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1:
    TextStyle(color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400));

const TextTheme TEXT_THEME_SMALL = TextTheme(
headline1: TextStyle(
color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
headline2: TextStyle(
color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
headline3: TextStyle(
color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
headline4: TextStyle(
color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
headline5: TextStyle(
color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
headline6: TextStyle(
color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 10),
bodyText1: TextStyle(
color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
bodyText2: TextStyle(
color:  COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
subtitle1:
TextStyle(color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400),
subtitle2: TextStyle(
color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400));