import 'dart:async';
import 'package:movie_alarm/Services/alarm_flag_manager.dart';
import 'package:movie_alarm/model/alarmstatus/status.dart';

class AlarmPollingWorker {
  static AlarmPollingWorker _instance = AlarmPollingWorker._();

  factory AlarmPollingWorker() {
    return _instance;
  }

  AlarmPollingWorker._();

  bool running = false;

  void createPollingWorker() {
    if (running) {
      //TODO Might be intended to run it again with 60 more iterations?
      // Probably have to figure out a way to address that.
      print('Worker is already running, not creating another one!');
      return;
    }

    running = true;
    _poller(120).then((callbackAlarmId) async {
      running = false;
      if (callbackAlarmId >= 0) {
        final alarmStatus = AlarmStatus();

        if (alarmStatus.alarmId < 0) {
          alarmStatus.fire(callbackAlarmId);
        }
        await AlarmFlagManager().clear();
      }
    });

  }

  // 알람 플래그를 찾은 경우 해당 알람 Id를 반환하고, 플래그가 없는 경우 null을 반환한다.
  Future<int> _poller(int iterations) async {
    late int alarmId;
    int iterator = 0;

    await Future.doWhile(() async {
      alarmId = await AlarmFlagManager().getFiredId();
      if (alarmId >= 0 || iterator++ >= iterations) return false;
      await Future.delayed(const Duration(milliseconds: 25));
      return true;
    });
    return alarmId;
  }

  /// Polling function checking for .alarm files in getApplicationDocumentsDirectory()
  /// every 10th of a for #iterations iterations.
  // Future<String> poller(int iterations) async {
  //   for (int i = 0; i < iterations; i++) {
  //     final foundFiles = await findFiles();
  //     if (foundFiles.length > 0) return foundFiles[0];
  //     await Future.delayed(const Duration(milliseconds: 100));
  //   }
  //
  //   return '';
  // }


  // Future<List<String>> findFiles() async {
  //   final extension = ".alarm";
  //   final dir = await getApplicationDocumentsDirectory();
  //   return dir
  //       .list()
  //       .map((entry) => entry.path)
  //       .where((path) => path.endsWith(extension))
  //       .map((path) => basename(path))
  //       .map((path) => path.substring(0, path.length - extension.length))
  //       .toList();
  // }
  //
  // void cleanUpAlarmFiles() async {
  //   print('Cleaning up generated .alarm files!');
  //   final dir = await getApplicationDocumentsDirectory();
  //   dir
  //       .list()
  //       .where((entry) => entry.path.endsWith(".alarm"))
  //       .forEach((entry) => entry.delete());
  // }
}
