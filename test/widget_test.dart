// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:push_up_count/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'push_up_session_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE push_up_session(id INTEGER PRIMARY KEY, numberPushUp INTEGER, sessionDate DATETIME)',
        );
      },
      version: 1,
    );


    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(database: database,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
