import 'package:flutter/material.dart';
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
      style: GoogleFonts.jua(),
      theme: GoogleFonts.juaTextTheme(),
    ),
    AppFontsType.hiMelody: (
      text: "Hi Melody",
      style: GoogleFonts.hiMelody(),
      theme: GoogleFonts.hiMelodyTextTheme(),
    ),
    AppFontsType.cute: (
      text: "Cute",
      style: GoogleFonts.cuteFont(),
      theme: GoogleFonts.cuteFontTextTheme(),
    ),
    AppFontsType.nanumGothic: (
      text: "Nanum Gothic",
      style: GoogleFonts.nanumGothic(),
      theme: GoogleFonts.nanumGothicTextTheme(),
    ),
    AppFontsType.nanumMyeongjo: (
      text: "Nanum Myeongjo",
      style: GoogleFonts.nanumMyeongjo(),
      theme: GoogleFonts.nanumMyeongjoTextTheme(),
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
