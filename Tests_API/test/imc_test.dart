import 'package:imc/imc.dart';
import 'package:test/test.dart';

void main() {
  //  Test with Triple A
  test('Must calculate IMC', () {
    // arrange
    final double height = 1.78;
    final double weight = 64;

    // act
    final result = calculateIMC(height, weight);

    // assert
    expect(result, equals(20.199469763918696));

    // most used matchers:
    expect(result, equals(20.199469763918696));
    expect(result, isA());
    expect(result, greaterThan(20));
    expect(result, isPositive);
    expect(result.toString(), matches(RegExp(r'\d')));
  });

  group('Parameters Exceptions -', () {
    test('Must throw exception if height is smaller than 1', () {
      expect(() => calculateIMC(0, 64), throwsA(isA<Exception>()));
    });

    test('Must throw exception if weight is smaller than 1', () {
      expect(() => calculateIMC(1.78, 0), throwsA(isA<Exception>()));
    });
  });
}
