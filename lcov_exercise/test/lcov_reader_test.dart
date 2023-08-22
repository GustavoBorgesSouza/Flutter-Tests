import 'package:lcov/lcov_reader.dart';
import 'package:test/test.dart';

void main() {
  test('Must get percentage of coverage', () {
    ///arrange
    ///act
    final result = coverage('./coverage/lcov.info');

    ///assert
    expect(result, '100%');
  });
}
