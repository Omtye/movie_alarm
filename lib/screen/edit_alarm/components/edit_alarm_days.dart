import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class EditAlarmDays extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmDays({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          WeekDayToggle(
            text: '월',
            current: alarm.monday,
            onToggle: (monday) => alarm.monday = monday,
          ),
          WeekDayToggle(
            text: '화',
            current: alarm.tuesday,
            onToggle: (tuesday) => alarm.tuesday = tuesday,
          ),
          WeekDayToggle(
            text: '수',
            current: alarm.wednesday,
            onToggle: (wednesday) => alarm.wednesday = wednesday,
          ),
          WeekDayToggle(
            text: '목',
            current: alarm.thursday,
            onToggle: (thursday) => alarm.thursday = thursday,
          ),
          WeekDayToggle(
            text: '금',
            current: alarm.friday,
            onToggle: (friday) => alarm.friday = friday,
          ),
          WeekDayToggle(
            text: '토',
            current: alarm.saturday,
            onToggle: (saturday) => alarm.saturday = saturday,
          ),
          WeekDayToggle(
            text: '일',
            current: alarm.sunday,
            onToggle: (sunday) => alarm.sunday = sunday,
          ),
        ],
      ),
    );
  }
}

class WeekDayToggle extends StatelessWidget {
  final Function onToggle;
  final bool current;
  final String text;

  const WeekDayToggle({Key? key, required this.onToggle, required this.current, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 20.0;
    final blobColor = this.current ? Colors.black : Colors.white;

    return GestureDetector(
      child: SizedBox.fromSize(
        size: Size.fromRadius(size),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
              border: Border.all(
                color: blobColor,
              ),),
          child: Center(
              child: Text(
            this.text,
            style: TextStyle(
              fontSize: 15,
            ),
          )),
        ),
      ),
      onTap: () => this.onToggle(!this.current),
    );
  }
}
