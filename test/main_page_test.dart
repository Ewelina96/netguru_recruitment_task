import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recruitment_task/pages/main_page.dart';

Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}

void main() {
  testWidgets('Display app bar', (WidgetTester tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.1;
    await tester.pumpWidget(
      buildTestableWidget(
        MainPage(),
      ),
    );

    expect(find.text('Netguru\'s Core Values'), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
  testWidgets('Display bottom bar', (WidgetTester tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.1;
    await tester.pumpWidget(
      buildTestableWidget(
        MainPage(),
      ),
    );

    expect(find.text('Values'), findsOneWidget);
    expect(find.text('Favorite'), findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(BottomAppBar), matching: find.byType(Icon)),
        findsNWidgets(3));
  });
}
