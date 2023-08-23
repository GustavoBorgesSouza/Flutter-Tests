import 'package:async_tests/stream.dart';
import 'package:test/test.dart';

void main() {
  test('Must complete the request and send a list of names', () {
    final stream = getStreamList();

    expect(stream, emitsInOrder(['virtual', 'insanity']));
    // primeiro a emitir
    // expect(stream, emits('virtual'));
    // expect(stream, emitsDone);
    // expect(stream, emitsError(Matcher));
  });
}
