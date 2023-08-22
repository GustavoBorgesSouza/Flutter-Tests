import 'dart:math';

// Método com 3 casos de testes e 3 casos de uso
double calculateIMC(double heigth, double weigth) {
  // caminho triste
  if (heigth < 1) {
    throw Exception('Altura não pode ser menor que 1');
  }

  // caminho triste
  if (weigth < 1) {
    throw Exception('Peso não pode ser menor que 1');
  }

  // caminho feliz
  return weigth / pow(heigth, 2);
  // return weigth / (heigth *  heigth);
}
