import 'package:lcov/lcov_reader.dart';
import 'package:lcov/line_report.dart';
import 'package:test/test.dart';

void main() {
  test('Must get percentage of coverage', () {
    ///arrange
    ///act
    final result = coverage('./coverage/lcov.info');

    ///assert
    expect(result, '100%');
  });

  test('Must calculate coverage in 50%', () {
    ///arrange
    final result = calculatePercentage([
      LineReport(sourceFile: '', lineFound: 18, lineHit: 9),
      LineReport(sourceFile: '', lineFound: 10, lineHit: 5),
    ]);

    ///act
    ///assert
    expect(result, equals(50));
  });
}
