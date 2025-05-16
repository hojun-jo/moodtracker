import 'package:flutter/material.dart';

class ChartStateRepository {
  ValueNotifier<bool> isChartSample = ValueNotifier(false);

  void setIsChartSample(bool value) {
    isChartSample.value = value;
  }
}
