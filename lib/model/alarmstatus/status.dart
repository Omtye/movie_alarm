import 'package:mobx/mobx.dart';

part 'status.g.dart';

class AlarmStatus extends _AlarmStatus with _$AlarmStatus {

  static final AlarmStatus _instance = AlarmStatus._();

  factory AlarmStatus() {
    return _instance;
  }

  AlarmStatus._();

}

abstract class _AlarmStatus with Store {

  @observable
  bool isAlarm = false;

  int alarmId = -1;

  @computed
  bool get isFired => isAlarm;

  // 알람을 작동시킨다.
  @action
  void fire(int id) {
    alarmId = id;
    isAlarm = true;
  }

  // 현재 울린 알람의 상태를 클리어한다.
  @action
  void clear() {
    isAlarm = false;
    alarmId = -1;
  }

}

