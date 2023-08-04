import 'package:flutter/material.dart';

class ColorManager{
  static Color yellow = HexColor.fromHex("#eee669");
  static Color darkBlue = HexColor.fromHex("#072530");
  static Color darkGrey = HexColor.fromHex("#3a3941");
  static Color orange = HexColor.fromHex("#fe7608");
  static Color darkOrange = HexColor.fromHex("#d98d1f");

  static Color whiteGreen = HexColor.fromHex("#bbebcc");
  static Color grey1 = HexColor.fromHex("#a0a099");
  static Color grey2 = HexColor.fromHex("#545459");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black= HexColor.fromHex("#000000"); // red color
}


  extension HexColor on Color{
   static Color fromHex(String hexColorString){
     hexColorString =hexColorString.replaceAll('#', '');
     if (hexColorString.length==6){
       hexColorString='FF' +hexColorString;
     }
     return Color(int.parse(hexColorString,radix: 16));
   }

}

// Hex color
//
// #FF0000     Pure Red
// #00FF00     Pure Green
// #0000FF     Pure Blue
//
// 0xFF002F6C
//
// A representing 10,
// B representing 11,
// C representing 12,
// D representing 13,
// E representing 14,
// F representing 15.
//
// Color myColor = Color(0xFF002F6C);
//
// Hex Opacity Values
// * 100% — FF
// * 95% — F2
// * 90% — E6
// * 85% — D9
// * 80% — CC
// * 75% — BF
// * 70% — B3
// * 65% — A6
// * 60% — 99
// * 55% — 8C
// * 50% — 80
// * 45% — 73
// * 40% — 66
// * 35% — 59
// * 30% — 4D
// * 25% — 40
// * 20% — 33
// * 15% — 26
// * 10% — 1A
// * 5% — 0D
// * 0% — 00
