import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MainNavigationType {
  home,
  write,
  chart,
  settings;

  static const _properties = {
    MainNavigationType.home: (icon: FontAwesomeIcons.book,),
    MainNavigationType.write: (icon: FontAwesomeIcons.featherPointed,),
    MainNavigationType.chart: (icon: FontAwesomeIcons.chartPie,),
    MainNavigationType.settings: (icon: FontAwesomeIcons.bars,),
  };

  IconData get icon => _properties[this]!.icon;
}
