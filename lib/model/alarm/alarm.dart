import 'package:mobx/mobx.dart';
import 'package:movie_alarm/model/observable/observable.dart';

part 'alarm.g.dart';

class AlarmList = _AlarmList with _$AlarmList;

abstract class _AlarmList with Store {

  _AlarmList();

  @observable
  ObservableList<ObservableAlarm> alarms = ObservableList();

  @action
  void setAlarms(List<ObservableAlarm> alarms) {
    this.alarms.clear();
    this.alarms.addAll(alarms);
  }

}
