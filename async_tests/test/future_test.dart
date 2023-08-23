import 'package:async_tests/future.dart';
import 'package:test/test.dart';

void main() {
  test('Must complete the request and send a list of names', () {
    final future = getFutureList();
    // expect(future, completes);
    // expect(future, completion(isA<List<String>>()));
    expect(future, completion(equals(['Virtual', 'Insanity'])));
  });
}

///Future matchers ->
///completes - verifica apenas se completou
///completion(matcher) - recebe um matcher