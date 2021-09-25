import 'package:flutter/material.dart';
import 'package:movie_alarm/Services/alarm_polling_worker.dart';
import 'package:movie_alarm/Services/file_proxy.dart';
import 'package:movie_alarm/model/alarm/alarm.dart';

class LifeCycleListener extends WidgetsBindingObserver {
  final AlarmList alarms;

  LifeCycleListener(this.alarms);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        saveAlarms();
        break;
      case AppLifecycleState.resumed:
        createAlarmPollingIsolate();
        break;
      default:
        print("Updated lifecycle state: $state");
    }
  }

  void saveAlarms() {
    alarms.alarms.forEach((alarm) => alarm.updateMusicPaths());
    JsonFileStorage().writeList(alarms.alarms);
  }

  void createAlarmPollingIsolate() {
    print('Creating a new worker to check for alarm files!');
    AlarmPollingWorker().createPollingWorker();
  }
}
