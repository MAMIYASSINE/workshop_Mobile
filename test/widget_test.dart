// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:workshop_flutter__4ei3/main.dart';

void main() {
  testWidgets('valide les formulaires et permet d’acheter un film', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 850);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('SIGN IN'));
    await tester.pumpAndSettle();
    expect(find.text('Email invalide'), findsOneWidget);
    expect(find.text('Password invalide'), findsOneWidget);

    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SEND RESET LINK'));
    await tester.pumpAndSettle();
    expect(find.text('Email invalide'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'sam@example.com');
    await tester.tap(find.text('SEND RESET LINK'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('CREATE AN ACCOUNT'));
    await tester.tap(find.text('CREATE AN ACCOUNT'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('SIGN UP'));
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();
    expect(find.text('Username invalide'), findsOneWidget);
    expect(find.text('Email invalide'), findsOneWidget);
    expect(find.text('Password invalide'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'sam');
    await tester.enterText(fields.at(1), 'sam@example.com');
    await tester.enterText(fields.at(2), 'secret1');
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('House Of Dead').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('The House of the Dead'), findsOneWidget);
    expect(find.text('300 DT'), findsOneWidget);
    expect(find.text('Acheter'), findsOneWidget);

    await tester.tap(find.text('Acheter'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Panier'));
    await tester.pumpAndSettle();
    expect(find.text('House Of Dead'), findsOneWidget);
    expect(find.text('Total : 300 DT'), findsOneWidget);

    final checkoutButton = find.widgetWithText(FilledButton, 'Acheter');
    await tester.ensureVisible(checkoutButton);
    await tester.tapAt(tester.getCenter(checkoutButton) - const Offset(0, 12));
    await tester.pumpAndSettle();
    expect(find.text('Bibliothèque'), findsWidgets);
    expect(find.text('Total : 300 DT'), findsNothing);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Update Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SAVE'));
    await tester.pumpAndSettle();
    expect(find.text('Current password cannot be empty'), findsOneWidget);
    expect(find.text('New password cannot be empty'), findsOneWidget);
    expect(find.text('Address cannot be empty'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Sign In'), findsOneWidget);
  });
}
