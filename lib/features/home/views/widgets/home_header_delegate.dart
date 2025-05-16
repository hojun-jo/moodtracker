import 'package:flutter/material.dart';
import 'package:moodtracker/features/home/views/widgets/home_header.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
<<<<<<< HEAD
=======
  final Function(DateTime?) onDateChanged;

  HomeHeaderDelegate({required this.onDateChanged});

>>>>>>> origin/main
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
<<<<<<< HEAD
    return const HomeHeader();
=======
    return HomeHeader(
      onDateChanged: onDateChanged,
    );
>>>>>>> origin/main
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
