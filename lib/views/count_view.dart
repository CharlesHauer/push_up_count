import 'package:flutter/material.dart';
import 'package:push_up_count/components/navBar/bottom_nav_bar_count_component.dart';
import 'package:push_up_count/models/push_up_session_model.dart';
import 'package:push_up_count/repositories/push_up_session_repository.dart';
import 'package:push_up_count/utils/convert_date_string.dart';
import 'package:sqflite/sqflite.dart';

class CountModel extends StatefulWidget {
  final Future<Database> database;
  const CountModel({super.key, required this.database});

  @override
  State<CountModel> createState() => _CountModelState();
}

class _CountModelState extends State<CountModel> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = '0';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }


  Future<void> _addPushUpSession() async {
    PushUpSessionRepository pushUpSessionRepository = PushUpSessionRepository(database: widget.database);
    int number = int.parse(_textEditingController.text);
    String sessionDate = ConvertDateString().dateToString(DateTime.now());
    int id = await pushUpSessionRepository.getNextIdPushUpSessions();
    PushUpSession pushUpSession = PushUpSession(id: id, numberPushUp: number, sessionDate: sessionDate);
    pushUpSessionRepository.insertPushUpSession(pushUpSession);

    setState(() {
      _textEditingController.text = '0';
    });
  }

  Future<void> _add() async {

    if (_textEditingController.text == '0'){
      return;
    }

    String s = 's';
    if (_textEditingController.text == '1') {
      s = '';
    }

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You did ${_textEditingController.text} push-up$s ?'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addPushUpSession();
                  },
                  child: const Icon(Icons.done),
                ),
              ],
            ),
          );
        }
    );
  }

  void _incrementCount() {
    int count = int.parse(_textEditingController.text);
    count++;
    setState(() {
      _textEditingController.text = '$count';
    });
  }

  void _decrementCount() {
    int count = int.parse(_textEditingController.text);
    if (count > 0) {
      count--;
      setState(() {
        _textEditingController.text = '$count';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: const Text('COUNT'),
        centerTitle: true,
        backgroundColor: Colors.black,

      ),

      body: SafeArea(

        child: Column (
          children: [

            const Padding(padding: EdgeInsets.only(top: 60)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Push-Up Count',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Image.asset(
                  'assets/images/icon.png',
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ],
            ),

            const Padding(padding: EdgeInsets.only(top:100)),

            const Text(
              'How many push-ups\nhave you done ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
              ),
            ),

            const Padding(padding: EdgeInsets.only(bottom:40)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _decrementCount,
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.black
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 60,
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
                      onSubmitted: (text) {
                        if (text.isEmpty){
                          setState(() {
                            _textEditingController.text = '0';
                          });
                        }
                      },
                      onTap: () {
                        _textEditingController.text = '';
                      },
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: _incrementCount,
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.black,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ],
            ),

            const Padding(padding: EdgeInsets.only(bottom:60)),

            ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30)),
                  backgroundColor: MaterialStatePropertyAll(Colors.black)
              ),
              onPressed: _add,
              child: const Text(
                'VALIDATE',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                ),
              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: BottomCount(database: widget.database,),
      ),

    );
  }
}

