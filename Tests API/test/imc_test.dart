import 'package:imc/imc.dart';
import 'package:test/test.dart';

void main() {
  test('Must calculate IMC', () {
    final result = calculateIMC(1.78, 64);

    expect(result, equals(20.199469763918696));
  });

  group('Parameters Exceptions -', () {
    test('Must throw exception if heigth is smaller than 1', () {
      expect(() => calculateIMC(0, 64), throwsA(isA<Exception>()));
    });

    test('Must throw exception if weigth is smaller than 1', () {
      expect(() => calculateIMC(1.78, 0), throwsA(isA<Exception>()));
    });
  });
}
