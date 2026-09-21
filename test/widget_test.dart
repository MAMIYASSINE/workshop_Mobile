// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:workshop_flutter__4ei3/main.dart';

void main() {
  testWidgets('ouvre la page de détail après un clic sur une carte', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('House Of Dead'));
    await tester.pumpAndSettle();

    expect(find.textContaining('The House of the Dead'), findsOneWidget);
    expect(find.text('300 DT'), findsOneWidget);
    expect(find.text('Acheter'), findsOneWidget);
  });
}
