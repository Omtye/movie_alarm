
import 'package:movie_alarm/Services/file_proxy.dart';
import 'package:movie_alarm/model/alarm/alarm.dart';
import 'package:movie_alarm/model/observable/observable.dart';

class AlarmListManager {
  final AlarmList _alarms;
  final JsonFileStorage _storage = JsonFileStorage();

  AlarmListManager(this._alarms);

  saveAlarm(ObservableAlarm alarm) async {
    await alarm.updateMusicPaths();
    final index = _alarms.alarms.indexWhere((findAlarm) => alarm.id == findAlarm.id);

    if (index == -1){
      _alarms.alarms.add(alarm);
    } else {
      _alarms.alarms[index] = alarm;
    }

    print(3);
    await _storage.writeList(_alarms.alarms);
  }
}
