import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum MainNavigationType {
  home,
  write,
  settings;

  int toIndex() {
    switch (this) {
      case MainNavigationType.home:
        return 0;
      case MainNavigationType.write:
        return 1;
      case MainNavigationType.settings:
        return 2;
    }
  }

  IconData toIcon() {
    switch (this) {
      case MainNavigationType.home:
        return FontAwesomeIcons.book;
      case MainNavigationType.write:
        return FontAwesomeIcons.featherPointed;
      case MainNavigationType.settings:
        return FontAwesomeIcons.bars;
    }
  }
}
