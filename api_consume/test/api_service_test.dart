import 'dart:async';

import 'package:api_consume/api_service.dart';
import 'package:api_consume/product.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:uno/uno.dart';

// mock creation here
class UnoMock extends Mock implements Uno {}

class ResponseMock extends Mock implements Response {}

void main() {
  test('Must return a list of products', () {
    final uno = UnoMock();
    final response = ResponseMock();

    // stubs config here
    when(() => response.data).thenReturn(productsListJson);
    when(() => uno.get(any())).thenAnswer((_) async => response);
    final service = APIService(uno);

    expect(
      service.getProducts(),
      completion([
        Product(id: 1, title: 'title1', price: 9.9),
        Product(id: 2, title: 'title2', price: 2.5),
      ]),
    );
  });
  test('Must return an empty list of products when there is an error', () {
    final uno = UnoMock();

    when(() => uno.get(any())).thenThrow(UnoError('error  '));

    final service = APIService(uno);

    expect(service.getProducts(), completion([]));
  });
}

final productsListJson = [
  {
    'id': 1,
    'title': 'title1',
    'price': 9.9,
  },
  {
    'id': 2,
    'title': 'title2',
    'price': 2.5,
  },
];
