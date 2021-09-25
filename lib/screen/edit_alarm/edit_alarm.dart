import 'package:flutter/material.dart';
import 'package:movie_alarm/Services/alarm_list_manager.dart';
import 'package:movie_alarm/model/observable/observable.dart';
import 'package:movie_alarm/screen/edit_alarm/components/buttom_button.dart';
import 'package:movie_alarm/screen/edit_alarm/components/edit_alarm_days.dart';
import 'package:movie_alarm/screen/edit_alarm/components/edit_alarm_embedded_video.dart';
import 'package:movie_alarm/screen/edit_alarm/components/edit_alarm_head.dart';
import 'package:movie_alarm/screen/edit_alarm/components/edit_alarm_music.dart';
import 'package:movie_alarm/screen/edit_alarm/components/edit_alarm_time.dart';

class EditAlarm extends StatelessWidget {
  final ObservableAlarm alarm;
  final AlarmListManager manager;

  EditAlarm({required this.alarm, required this.manager});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height - (size.height / 15),
                child: Stack(
                  children: <Widget>[
                    EditAlarmTime(alarm: this.alarm),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.35),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              EditAlarmHead(alarm: this.alarm),
                              Divider(),
                              EditAlarmDays(alarm: this.alarm),
                              Divider(),
                              EditAlarmMusic(alarm: this.alarm),
                              Divider(),
                              EditAlarmEmbeddedVideo(alarm: this.alarm),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ButttomButton(
                  alarm: this.alarm,
                  manager: manager,
                  height: size.height / 15),
            ],
          ),
        ),
      ),
    );
  }

}
