import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class EditAlarmHead extends StatelessWidget {
  final ObservableAlarm alarm;

  EditAlarmHead({required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "알람 이름"),
                  controller: TextEditingController(text: alarm.name),
                  style: TextStyle(fontSize: 15),
                  onChanged: (newName) => alarm.name = newName,
                )
              ],
            ),
          ),
          Observer(
            builder: (context) => IconButton(
              icon: alarm.active
                  ? Icon(Icons.alarm, color: Colors.deepOrange)
                  : Icon(Icons.alarm_off),
              onPressed: () => alarm.active = !alarm.active,
            ),
          )
        ],
      ),
    );
  }
}
