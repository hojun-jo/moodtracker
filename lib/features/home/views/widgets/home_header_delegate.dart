import 'package:flutter/material.dart';
import 'package:moodtracker/features/home/views/widgets/home_header.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Function(DateTimeRange?) onDateChanged;

  HomeHeaderDelegate({required this.onDateChanged});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return HomeHeader(onDateChanged: onDateChanged);
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
