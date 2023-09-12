import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widget_tests/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // used once, only in the beggining.
    await tester.pumpWidget(const MyApp());

    // find
    // used for searching almost everything in the widget tree

    /// 3 new matchers for flutter
    /// 1 - findsOneWidget : verifies if it finds ONE widget
    /// 2 - findsNothing : verifies if it finds nothing
    /// 3 - findsWidgets : verifies if it finds more than 0 widgets

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    // pump has to be used when setState is called or state changes
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
