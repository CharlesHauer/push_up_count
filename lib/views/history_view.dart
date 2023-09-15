import 'package:flutter/material.dart';
import 'package:push_up_count/components/history_setting_session_components.dart';
import 'package:push_up_count/components/navBar/bottom_nav_bar_history_component.dart';
import 'package:push_up_count/models/push_up_session_model.dart';
import 'package:push_up_count/utils/convert_date_string.dart';
import 'package:sqflite/sqflite.dart';
import '../repositories/push_up_session_repository.dart';


class HistoryView extends StatefulWidget {
  final Future<Database> database;
  const HistoryView({super.key, required this.database});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<PushUpSession> repository = [];

  @override
  void initState() {
    super.initState();
    _fetchPushUpSessions();
  }

  Future<void> _fetchPushUpSessions() async {
    final Future<Database> database = widget.database;

    final List<PushUpSession> fetchedData =
      await PushUpSessionRepository(database: database).getPushUpSessions();
    setState(() {
      repository = fetchedData;
    });
  }


  @override
  Widget build(BuildContext context) {
    repository.sort((a,b) {
      DateTime dateA = ConvertDateString().stringToDate(a.sessionDate);
      DateTime dateB = ConvertDateString().stringToDate(b.sessionDate);
      return dateB.compareTo(dateA);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('HISTORY'),
      ),
      body:  SafeArea(
        child: Center(
          child: ListView.builder(
            itemCount: repository.length,
            itemBuilder: (context, index) {
              PushUpSession session = repository[index];
              return Card(
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Image.asset(
                    'assets/images/icon.png',
                    width: 50,
                  ),
                  title: Text(
                    '${session.numberPushUp} push-ups',
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Row(
                    children: [
                      const SizedBox(
                        height: 30,
                        width: 2,
                      ),
                      Text(
                        session.sessionDate.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton (
                    onPressed: () async {
                      HistorySettingSessionComponents historySettingSessionComponents = HistorySettingSessionComponents(widget.database ,context, repository[index]);
                      await historySettingSessionComponents.open();
                      _fetchPushUpSessions();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),

      bottomNavigationBar: BottomHistory(database: widget.database,),
    );
  }
}
