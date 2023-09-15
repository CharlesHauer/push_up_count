import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:push_up_count/repositories/push_up_session_repository.dart';
import 'package:push_up_count/utils/convert_date_string.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

import 'models/push_up_session_model.dart';
import 'views/count_view.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.black,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'push_up_session_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE push_up_session(id INTEGER PRIMARY KEY, numberPushUp INTEGER, sessionDate STRING)',
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Future<Database> database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    PushUpSessionRepository pushUpSessionRepository = PushUpSessionRepository(database: database);
    String sessionDate = ConvertDateString().dateToString(DateTime(2023, 8, 7));
    PushUpSession pushUpSession = PushUpSession(id: 0, numberPushUp: 60, sessionDate: sessionDate);
    pushUpSessionRepository.insertPushUpSession(pushUpSession);
    String sessionDate1 = ConvertDateString().dateToString(DateTime(2023, 8, 8));
    pushUpSession = PushUpSession(id: 1, numberPushUp: 55, sessionDate: sessionDate1);
    pushUpSessionRepository.insertPushUpSession(pushUpSession);
    String sessionDate2 = ConvertDateString().dateToString(DateTime(2023, 8, 9));
    pushUpSession = PushUpSession(id: 2, numberPushUp: 105, sessionDate: sessionDate2);
    pushUpSessionRepository.insertPushUpSession(pushUpSession);
    String sessionDate3 = ConvertDateString().dateToString(DateTime(2023, 8, 10));
    pushUpSession = PushUpSession(id: 3, numberPushUp: 80, sessionDate: sessionDate3);
    pushUpSessionRepository.insertPushUpSession(pushUpSession);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CountModel(database: database,),
    );
  }
}

