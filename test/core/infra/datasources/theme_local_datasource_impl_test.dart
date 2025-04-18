import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodtracker/core/infra/datasources/theme_local_datasource_impl.dart';

import '../../../mock.dart';

void main() {
  late MockSharedPreferencesAsync mockAsyncPref;
  late ThemeLocalDatasourceImpl datasource;

  setUp(() {
    mockAsyncPref = MockSharedPreferencesAsync();
    datasource = ThemeLocalDatasourceImpl(asyncPref: mockAsyncPref);
  });

  group("getTheme", () {
    test("should return the correct theme", () async {
      // given
      when(() => mockAsyncPref.getString("theme"))
          .thenAnswer((_) async => "almond");

      // when
      final result = await datasource.getTheme();

      // then
      expect(result, "almond");
    });

    test("should return null if the theme is not saved", () async {
      // given
      when(() => mockAsyncPref.getString("theme"))
          .thenAnswer((_) async => null);

      // when
      final result = await datasource.getTheme();

      // then
      expect(result, null);
    });
  });

  group("setTheme", () {
    test("should save the correct theme", () async {
      // given
      when(() => mockAsyncPref.setString("theme", "almond"))
          .thenAnswer((_) async => true);

      // when
      await datasource.setTheme("almond");

      // then
      verify(() => mockAsyncPref.setString("theme", "almond")).called(1);
    });
  });

  test("should throw an error if the theme is not saved", () async {
    // given
    when(() => mockAsyncPref.setString("theme", "almond"))
        .thenThrow(Exception());

    // when
    // then
    await expectLater(
      datasource.setTheme("almond"),
      throwsA(isA<Exception>()),
    );
  });
}
