// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlarmStatus on _AlarmStatus, Store {
  Computed<bool>? _$isFiredComputed;

  @override
  bool get isFired => (_$isFiredComputed ??=
          Computed<bool>(() => super.isFired, name: '_AlarmStatus.isFired'))
      .value;

  final _$isAlarmAtom = Atom(name: '_AlarmStatus.isAlarm');

  @override
  bool get isAlarm {
    _$isAlarmAtom.reportRead();
    return super.isAlarm;
  }

  @override
  set isAlarm(bool value) {
    _$isAlarmAtom.reportWrite(value, super.isAlarm, () {
      super.isAlarm = value;
    });
  }

  final _$_AlarmStatusActionController = ActionController(name: '_AlarmStatus');

  @override
  void fire(int id) {
    final _$actionInfo =
        _$_AlarmStatusActionController.startAction(name: '_AlarmStatus.fire');
    try {
      return super.fire(id);
    } finally {
      _$_AlarmStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo =
        _$_AlarmStatusActionController.startAction(name: '_AlarmStatus.clear');
    try {
      return super.clear();
    } finally {
      _$_AlarmStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAlarm: ${isAlarm},
isFired: ${isFired}
    ''';
  }
}
