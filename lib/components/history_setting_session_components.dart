import 'package:flutter/material.dart';
import 'package:push_up_count/components/update_session_component.dart';
import 'package:push_up_count/models/push_up_session_model.dart';
import 'package:push_up_count/repositories/push_up_session_repository.dart';
import 'package:sqflite/sqflite.dart';

class HistorySettingSessionComponents {
  final Future<Database> database;
  BuildContext context;
  PushUpSession pushUpSession;

  HistorySettingSessionComponents(this.database,this.context, this.pushUpSession);


  Future open() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:   const Center(
              child: Text('Push-up session'),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You did ${pushUpSession.numberPushUp} push-ups\n'
                    'On ${pushUpSession.sessionDate}'),
              ],
            ),
            actions:
            <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UpdateSession(pushUpSession: pushUpSession, database: database),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        await PushUpSessionRepository(database: database).deletePushUpSession(pushUpSession.id);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )

              )
            ],
          );
        }
    );
  }
}