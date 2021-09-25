import 'package:flutter/material.dart';
import 'package:movie_alarm/Services/alarm_list_manager.dart';
import 'package:movie_alarm/Services/alarm_scheduler.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class ButttomButton extends StatelessWidget {
  final ObservableAlarm alarm;
  final AlarmListManager manager;
  final height;

  const ButttomButton(
      {Key? key, required this.alarm, required this.manager, this.height,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: height,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("취소"),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: height,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("저장"),
                ),
                onTap: () async {
                  await manager.saveAlarm(alarm);
                  await AlarmScheduler().scheduleAlarm(alarm);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
