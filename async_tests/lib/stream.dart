Stream<String> getStreamList() async* {
  yield 'virtual';
  await Future.delayed(Duration(seconds: 1));
  yield 'insanity';
}
