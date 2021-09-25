import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_alarm/Services/alarm_list_manager.dart';
import 'package:movie_alarm/Services/alarm_scheduler.dart';
import 'package:movie_alarm/components/alarm_item/alarm_item.dart';
import 'package:movie_alarm/components/bottom_add_button/bottom_add_button.dart';
import 'package:movie_alarm/components/default_container/default_container.dart';
import 'package:movie_alarm/model/alarm/alarm.dart';
import 'package:movie_alarm/model/observable/observable.dart';
import 'package:movie_alarm/screen/edit_alarm/edit_alarm.dart';

class HomeScreen extends StatelessWidget {
  final AlarmList alarms;

  const HomeScreen({Key? key, required this.alarms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlarmListManager _manager = AlarmListManager(alarms);

    return DefaultContainer(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Observer(
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final alarm = alarms.alarms[index];
                  return Dismissible(
                    key: Key(alarm.id.toString()),
                    child: AlarmItem(alarm: alarm, manager: _manager),
                    onDismissed: (_) {
                      AlarmScheduler().clearAlarm(alarm);
                      alarms.alarms.removeAt(index);
                    },
                  );
                },
                itemCount: alarms.alarms.length,
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
          BottomAddButton(
            onPressed: () async {
              TimeOfDay tod = TimeOfDay.fromDateTime(DateTime.now());

              final songs = await FlutterAudioQuery().getSongs();

              final newAlarm = ObservableAlarm.dayList(
                  alarms.alarms.length,
                  '',
                  tod.hour,
                  tod.minute,
                  0.3,
                  true,
                  List.filled(7, false),
                  ObservableList<String>.of([songs.first.id.toString()]),
                  <String>[],
                  '');

              await newAlarm.loadTracks();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAlarm(
                    alarm: newAlarm,
                    manager: _manager,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
