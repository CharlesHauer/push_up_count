import 'package:flutter/material.dart';
import 'package:push_up_count/repositories/push_up_session_repository.dart';
import 'package:sqflite/sqflite.dart';
import '../models/push_up_session_model.dart';


class UpdateSession extends StatefulWidget {
  final Future<Database> database;
  final PushUpSession pushUpSession;
  const UpdateSession({super.key, required this.pushUpSession, required this.database});

  @override
  State<UpdateSession> createState() => _UpdateSessionState();
}

class _UpdateSessionState extends State<UpdateSession> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    PushUpSession pushUpSession = widget.pushUpSession;
    _textEditingController.text = pushUpSession.numberPushUp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await dialogBuilder();
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black
      ),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

  @override
  Future<void> update(PushUpSession  pushUpSession) async {
    PushUpSession newSession = PushUpSession(
      id: pushUpSession.id,
      numberPushUp:  int.parse(_textEditingController.text),
      sessionDate: pushUpSession.sessionDate,
    );
    await PushUpSessionRepository(database: widget.database).updatePushUpSession(newSession);
  }


  Future<void> dialogBuilder() {
    PushUpSession pushUpSession = widget.pushUpSession;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Edit the session of ${pushUpSession.sessionDate}',
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'Before the update you did'
                      '\n${pushUpSession.numberPushUp} push-ups',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 4
                  ),
                ),
                child: Center(
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    onTap: () {
                      _textEditingController.text = '';
                    },
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      update(pushUpSession);
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}