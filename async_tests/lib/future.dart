Future<List<String>> getFutureList() async {
  await Future.delayed(Duration(seconds: 1));
  return ['Virtual', 'Insanity'];
}
