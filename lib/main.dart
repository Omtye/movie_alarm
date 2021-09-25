import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_alarm/Services/alarm_polling_worker.dart';
import 'package:movie_alarm/Services/file_proxy.dart';
import 'package:movie_alarm/Services/life_cycle_listener.dart';
import 'package:movie_alarm/Services/media_handler.dart';
import 'package:movie_alarm/model/alarm/alarm.dart';
import 'package:movie_alarm/model/alarmstatus/status.dart';
import 'package:movie_alarm/screen/alarm_screen/alarm_screen.dart';
import 'package:movie_alarm/screen/home_screen/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:volume/volume.dart';
import 'package:wakelock/wakelock.dart';

AlarmList list = AlarmList();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final alarms = await new JsonFileStorage().readList();

  list.setAlarms(alarms);
  list.alarms.forEach((alarm) {
    alarm.loadTracks();
    alarm.loadPlaylists();
  });
  WidgetsBinding.instance!.addObserver(LifeCycleListener(list));

  runApp(MyApp());
  await AndroidAlarmManager.initialize();
  AlarmPollingWorker().createPollingWorker();

  final externalPath = (await getExternalStorageDirectory());
  print(externalPath!.path);
  if (!externalPath.existsSync()) externalPath.create(recursive: true);

  Volume.controlVolume(AudioManager.STREAM_MUSIC);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor:
              Color(0xFFe9ecef) //Color.fromRGBO(25, 12, 38, 1),
          ),
      home: Observer(
        builder: (context) {
          AlarmStatus status = AlarmStatus();
          if (status.isAlarm) {
            final id = status.alarmId;
            final alarm = list.alarms.firstWhere((alarm) => alarm.id == id);

            MediaHandler mediaHandler = MediaHandler();

            mediaHandler.changeVolume(alarm);
            mediaHandler.playMusic(alarm);
            Wakelock.enable();

            return AlarmScreen(alarm: alarm, mediaHandler: mediaHandler);
          }
          return HomeScreen(alarms: list);
        },
      ),
    );
  }
}
