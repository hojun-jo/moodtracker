import 'package:flutter_test/flutter_test.dart';
import 'package:moodtracker/features/chart/repositories/chart_state_repository.dart';

void main() {
  late ChartStateRepository repository;

  setUp(() {
    repository = ChartStateRepository();
  });

  test(
      'given initial state, when repository is created, then isChartSample is false',
      () {
    expect(repository.isChartSample.value, false);
  });

  test(
      'given false state, when setIsChartSample is called with true, then isChartSample becomes true',
      () {
    // given
    expect(repository.isChartSample.value, false);

    // when
    repository.setIsChartSample(true);

    // then
    expect(repository.isChartSample.value, true);
  });

  test(
      'given true state, when setIsChartSample is called with false, then isChartSample becomes false',
      () {
    // given
    repository.setIsChartSample(true);
    expect(repository.isChartSample.value, true);

    // when
    repository.setIsChartSample(false);

    // then
    expect(repository.isChartSample.value, false);
  });

  test(
      'given any state, when setIsChartSample is called multiple times, then isChartSample reflects last value',
      () {
    // given
    expect(repository.isChartSample.value, false);

    // when
    repository.setIsChartSample(true);
    repository.setIsChartSample(false);
    repository.setIsChartSample(true);
    repository.setIsChartSample(true);
    repository.setIsChartSample(false);

    // then
    expect(repository.isChartSample.value, false);
  });

  test(
      'given any state, when isChartSample is changed, then ValueNotifier notifies listeners',
      () {
    // given
    var notifiedCount = 0;
    repository.isChartSample.addListener(() {
      notifiedCount++;
    });

    // when
    repository.setIsChartSample(true);
    repository.setIsChartSample(false);
    repository.setIsChartSample(true);

    // then
    expect(notifiedCount, 3);
  });
}
