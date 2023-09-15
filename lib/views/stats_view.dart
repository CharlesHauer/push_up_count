import 'package:flutter/material.dart';
import 'package:push_up_count/components/navBar/bottom_nav_bar_stats_component.dart';
import 'package:push_up_count/components/stat_filter_button_component.dart';
import 'package:push_up_count/controler/ControlerStats.dart';
import 'package:sqflite/sqflite.dart';

import '../models/push_up_session_model.dart';
import '../repositories/push_up_session_repository.dart';

class StatsView extends StatefulWidget {
  final Future<Database> database;
  const StatsView({super.key, required this.database});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  List<PushUpSession> repository = [];
  String axe = 'week';

  @override
  void initState() {
    print('here');
    print(DateTime(2023, 8, 6).weekday);
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

  String? dropdownvalue = 'week';
  var choice = [
    'week',
    'month',
    'year'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: const Text('STATS'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          DropdownButton(
            dropdownColor: Colors.black,
            value: dropdownvalue,
            items: choice.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                axe = newValue!;
                dropdownvalue = newValue;
              });
            },
          ),
        ],
      ),
      body: ControlerStats(repository: repository, axe: axe),
      bottomNavigationBar: BottomStats(database: widget.database),
    );
  }
}
