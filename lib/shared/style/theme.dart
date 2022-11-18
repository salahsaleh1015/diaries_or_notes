import 'package:diaries_or_notes/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(

    textTheme:  const TextTheme(
        caption: TextStyle(fontSize: 16,color: Colors.white),
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600,fontFamily: "PT Serif"),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,

    ),
    // primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: HexColor("333739"),
    appBarTheme: AppBarTheme(
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 26),
        color: HexColor("333739"),
        elevation: 0.0,
        backwardsCompatibility: false,
        titleTextStyle: const TextStyle(
          fontFamily: "PT Serif",
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor("333739"),
          statusBarIconBrightness: Brightness.light,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor("333739"),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultLightColor,
      elevation: 10,
    ));
ThemeData lightTheme = ThemeData(
    iconTheme: IconThemeData(
      color: Colors.grey,

    ),
    textTheme:  const TextTheme(


        bodyText1: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600,fontFamily: "PT Serif"),
        caption: TextStyle(fontSize: 16,color: Colors.grey)),

    // primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.black, size: 26),
        color: Colors.white,
        elevation: 0.0,
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
          fontFamily: "PT Serif",
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[100],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultLightColor,
      elevation: 10,
    ));