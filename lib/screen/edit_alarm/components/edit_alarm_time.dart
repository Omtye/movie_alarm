import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/components/time_picker/time_picker_spinner.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class EditAlarmTime extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmTime({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.07),
      child: Observer(
        builder: (context) {
          final hours = alarm.hour;
          final minutes = alarm.minute;

          return new Column(
            children: <Widget>[
              TimePickerSpinner(
                time: DateTime(2021, 8, 25, hours, minutes),
                is24HourMode: false,
                spacing: width * 0.2,
                normalTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                ),
                highlightedTextStyle:
                    TextStyle(color: Colors.black, fontSize: 35),
                onTimeChange: (time) {
                  alarm.hour = time.hour;
                  alarm.minute = time.minute;
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget hourMinute12H() {
    return new TimePickerSpinner(
      is24HourMode: false,
      spacing: 90,
      onTimeChange: (time) {},
    );
  }
}
