import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFontsType {
  jua,
  hiMelody,
  cute,
  nanumGothic,
  nanumMyeongjo;

  static final _properties = {
    AppFontsType.jua: (
      text: "Jua",
      style:
          kDebugMode ? const TextStyle(fontFamily: 'Jua') : GoogleFonts.jua(),
      theme: kDebugMode ? const TextTheme() : GoogleFonts.juaTextTheme(),
    ),
    AppFontsType.hiMelody: (
      text: "Hi Melody",
      style: kDebugMode
          ? const TextStyle(fontFamily: 'Hi Melody')
          : GoogleFonts.hiMelody(),
      theme: kDebugMode ? const TextTheme() : GoogleFonts.hiMelodyTextTheme(),
    ),
    AppFontsType.cute: (
      text: "Cute",
      style: kDebugMode
          ? const TextStyle(fontFamily: 'Cute')
          : GoogleFonts.cuteFont(),
      theme: kDebugMode ? const TextTheme() : GoogleFonts.cuteFontTextTheme(),
    ),
    AppFontsType.nanumGothic: (
      text: "Nanum Gothic",
      style: kDebugMode
          ? const TextStyle(fontFamily: 'Nanum Gothic')
          : GoogleFonts.nanumGothic(),
      theme:
          kDebugMode ? const TextTheme() : GoogleFonts.nanumGothicTextTheme(),
    ),
    AppFontsType.nanumMyeongjo: (
      text: "Nanum Myeongjo",
      style: kDebugMode
          ? const TextStyle(fontFamily: 'Nanum Myeongjo')
          : GoogleFonts.nanumMyeongjo(),
      theme:
          kDebugMode ? const TextTheme() : GoogleFonts.nanumMyeongjoTextTheme(),
    ),
  };

  factory AppFontsType.fromString(String text) {
    return _properties.entries
        .where((e) => e.value.text == text)
        .map((e) => e.key)
        .first;
  }

  String get text => _properties[this]!.text;

  TextStyle get style => _properties[this]!.style;

  TextTheme get theme => _properties[this]!.theme;
}
