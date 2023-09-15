import 'package:sqflite/sqflite.dart';
import '../models/push_up_session_model.dart';
import 'dart:async';

class PushUpSessionRepository {
  final Future<Database> database;

  const PushUpSessionRepository({
    required this.database,
  });

  Future<int> getNextIdPushUpSessions () async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('push_up_session');
    return maps.length;
  }

  Future<void> insertPushUpSession(PushUpSession pushUpSession) async {
    final db = await database;
    await db.insert(
      'push_up_session',
      pushUpSession.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletePushUpSession(int id) async {
    final db = await database;

    await db.delete(
      'push_up_session',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updatePushUpSession(PushUpSession pushUpSession) async {
    final db = await database;

    await db.update(
      'push_up_session',
      pushUpSession.toMap(),
      where: 'id = ?',
      whereArgs: [pushUpSession.id],
    );
  }

  Future<List<PushUpSession>> getPushUpSessions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('push_up_session');

    List<PushUpSession> listResult = List.generate(maps.length, (i) {
      return PushUpSession(
        id: maps[i]['id'],
        numberPushUp: maps[i]['numberPushUp'],
        sessionDate: maps[i]['sessionDate'],
      );
    });
    return listResult;
  }

}