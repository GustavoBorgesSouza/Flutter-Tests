import 'package:imc/imc.dart';
import 'package:test/test.dart';

void main() {
  test('Must calculate IMC', () {
    final result = calculateIMC(1.78, 64);

    expect(result, equals(20.199469763918696));
  });

  // se criarmos na mão podemos fazer assim
  // if (calculateIMC(1.78, 64) == 20.199469763918696) {
  //   print("OK: ");
  // } else {
  //   print("ERROR: Must calculate IMC");
  // }

  test('Must throw exception if heigth is smaller than 1', () {
    expect(() => calculateIMC(0, 64), throwsA(isA<Exception>()));
  });

  // se criarmos na mão podemos fazer assim
  // try {
  //   calculateIMC(0, 64);
  //   print("ERROR: Must throw exception if heigth is smaller than 1");
  // } catch (e) {
  //   print("OK: Must throw exception if heigth is smaller than 1");
  // }

  test('Must throw exception if weigth is smaller than 1', () {
    expect(() => calculateIMC(1.78, 0), throwsA(isA<Exception>()));
  });
}
