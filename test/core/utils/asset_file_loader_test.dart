import 'package:flutter_test/flutter_test.dart';
import 'package:moodtracker/core/utils/file_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AssetFileLoader loader;

  setUp(() {
    loader = AssetFileLoader();
  });

  test('loads valid asset file successfully', () async {
    // given
    const path = 'test/assets/test_file.txt';
    const expectedContent = '''This is a test file for AssetFileLoader test.
It contains some sample text to verify file loading functionality.''';

    // when
    final result = await loader.loadString(path);

    // then
    expect(result, expectedContent);
  });

  test('throws error for non-existent file', () {
    // given
    const invalidPath = 'test/assets/non_existent_file.txt';

    // when, then
    expectLater(
      loader.loadString(invalidPath),
      throwsA(
        predicate(
          (e) => e.toString().contains('Unable to load asset'),
          'Error containing "Unable to load asset" message',
        ),
      ),
    );
  });

  test('throws error for empty path', () {
    // given
    const emptyPath = '';

    // when, then
    expectLater(
      loader.loadString(emptyPath),
      throwsA(
        predicate(
          (e) => e.toString().contains('Unable to load asset'),
          'Error containing "Unable to load asset" message',
        ),
      ),
    );
  });
}
