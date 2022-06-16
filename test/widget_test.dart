// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colorpick_flutter/menu_page.dart';
import 'package:colorpick_flutter/settings.dart';

void main() {
  testWidgets('Menu and Settings page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MenuPage()));

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    expect(find.byIcon(Icons.account_circle_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.pumpWidget(MaterialApp(home: Settings()));
    
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    expect(find.text("Dark mode: "), findsOneWidget);


  });
}
