
import 'package:flutter/material.dart';
import 'package:push_up_count/views/history_view.dart';
import 'package:sqflite/sqflite.dart';

import '../../views/count_view.dart';

class BottomStats  extends StatelessWidget {
  final Future<Database> database;

  const BottomStats({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: maxWidth/3,
          height: 80,
          child: ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HistoryView(database: database,)
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                )
            ),
            child: const Icon(
              Icons.history,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        SizedBox(
          width: maxWidth/3,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CountModel(database: database,)
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                )
            ),
            child: Image.asset(
              'assets/images/icon.png',
              width: 60,
            ),
          ),
        ),
        SizedBox(
          width: maxWidth/3,
          height: 80,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                )
            ),
            child: const Icon(
              Icons.query_stats,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
