import 'dart:async';

import 'package:api_consume/api_service.dart';
import 'package:api_consume/product.dart';
import 'package:test/test.dart';
import 'package:uno/uno.dart';

class UnoMock implements Uno {
  final bool withError;

  UnoMock([this.withError = false]);

  @override
  Future<Response> get(String url,
      {Duration? timeout,
      Map<String, String> params = const {},
      Map<String, String> headers = const {},
      ResponseType responseType = ResponseType.json,
      DownloadCallback? onDownloadProgress,
      ValidateCallback? validateStatus}) async {
    if (withError) {
      throw UnoError('error');
    }

    return Response(
      headers: headers,
      request: Request(
        headers: {},
        method: '',
        timeout: Duration(seconds: 1),
        uri: Uri.base,
      ),
      status: 200,
      data: productsListJson,
    );
  }

  // tudo chamado que não foi implementado cai aqui
  @override
  noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  test('Must return a list of products', () {
    final uno = UnoMock();
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
    final uno = UnoMock(true);
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
