import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/chart/repositories/chart_date_range_repository.dart';
import 'package:moodtracker/features/chart/providers/provider.dart';

void main() {
  late ProviderContainer container;
  late ChartDateRangeRepository repository;

  setUp(() {
    container = ProviderContainer();
    repository = container.read(chartDateRangeProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test(
      'given initial state, when build is called, then returns current month range',
      () {
    // given
    final now = DateTime.now();
    final expectedStart = DateTime(now.year, now.month);
    final expectedEnd = DateTime(now.year, now.month, now.day);

    // when
    final result = repository.build();

    // then
    expect(
      DateTime(result.start.year, result.start.month, result.start.day),
      DateTime(expectedStart.year, expectedStart.month, expectedStart.day),
    );
    expect(
      DateTime(result.end.year, result.end.month, result.end.day),
      DateTime(expectedEnd.year, expectedEnd.month, expectedEnd.day),
    );
  });

  test(
      'given specific date, when setChartDate is called, then returns that month range',
      () {
    // given
    final date = DateTime(2024, 5, 15);
    final expectedStart = DateTime(2024, 5, 1);
    final expectedEnd = DateTime(2024, 5, 31);

    // when
    repository.setChartDate(date);

    // then
    expect(
      DateTime(repository.state.start.year, repository.state.start.month,
          repository.state.start.day),
      DateTime(expectedStart.year, expectedStart.month, expectedStart.day),
    );
    expect(
      DateTime(repository.state.end.year, repository.state.end.month,
          repository.state.end.day),
      DateTime(expectedEnd.year, expectedEnd.month, expectedEnd.day),
    );
  });

  test(
      'given date at year boundary, when setChartDate is called, then returns correct month range',
      () {
    // given
    final date = DateTime(2024, 12, 15);
    final expectedStart = DateTime(2024, 12, 1);
    final expectedEnd = DateTime(2024, 12, 31);

    // when
    repository.setChartDate(date);

    // then
    expect(
      DateTime(repository.state.start.year, repository.state.start.month,
          repository.state.start.day),
      DateTime(expectedStart.year, expectedStart.month, expectedStart.day),
    );
    expect(
      DateTime(repository.state.end.year, repository.state.end.month,
          repository.state.end.day),
      DateTime(expectedEnd.year, expectedEnd.month, expectedEnd.day),
    );
  });

  test(
      'given date at month boundary, when setChartDate is called, then returns correct month range',
      () {
    // given
    final date = DateTime(2024, 2, 29); // Leap year February
    final expectedStart = DateTime(2024, 2, 1);
    final expectedEnd = DateTime(2024, 2, 29);

    // when
    repository.setChartDate(date);

    // then
    expect(
      DateTime(repository.state.start.year, repository.state.start.month,
          repository.state.start.day),
      DateTime(expectedStart.year, expectedStart.month, expectedStart.day),
    );
    expect(
      DateTime(repository.state.end.year, repository.state.end.month,
          repository.state.end.day),
      DateTime(expectedEnd.year, expectedEnd.month, expectedEnd.day),
    );
  });
}
