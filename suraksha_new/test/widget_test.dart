// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suraksha_new/main.dart';
import 'package:suraksha_new/translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  testWidgets('App loads and shows language selector', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('ta'),
        Locale('te'),
        Locale('ml'),
        Locale('bn'),
      ],
      home: Scaffold(
        body: TomTomMap(
          onLocaleChange: (Locale locale) {
            // Mock callback
          },
        ),
      ),
    ));

    // Verify app bar is present
    expect(find.byType(AppBar), findsOneWidget);
    
    // Verify language selector is present
    expect(find.byIcon(Icons.language), findsOneWidget);
  });

  testWidgets('App title shows correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: Scaffold(
        body: TomTomMap(
          onLocaleChange: (Locale locale) {
            // Mock callback
          },
        ),
      ),
    ));

    // Verify app title is present
    expect(find.text('Suraksha'), findsOneWidget);
  });
}
