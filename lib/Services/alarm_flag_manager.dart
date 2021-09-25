import 'package:shared_preferences/shared_preferences.dart';

class AlarmFlagManager {
  static final AlarmFlagManager _instance = AlarmFlagManager._();

  factory AlarmFlagManager() => _instance;

  AlarmFlagManager._();

  static const String _alarmFlagKey = "alarmFlagKey";

  Future<void> set(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_alarmFlagKey, id);
  }

  Future<int> getFiredId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    if (prefs.getInt(_alarmFlagKey) == null)
      return -1;
    return prefs.getInt(_alarmFlagKey)! ;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_alarmFlagKey);
  }
}