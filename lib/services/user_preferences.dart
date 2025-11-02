import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _nameKey = 'user_name';
  static const String _ageKey = 'user_age';
  static const String _emailKey = 'user_email';
  static const String _goalKey = 'user_goal';
  static const String _currentWeightKey = 'current_weight';
  static const String _targetWeightKey = 'target_weight';
  static const String _weeklyProgressKey = 'weekly_progress';

  // Singleton pattern
  static UserPreferences? _instance;
  static SharedPreferences? _prefs;

  UserPreferences._();

  static Future<UserPreferences> getInstance() async {
    _instance ??= UserPreferences._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Métodos para datos de usuario
  Future<void> saveUserName(String name) async {
    await _prefs!.setString(_nameKey, name);
  }

  String getUserName() {
    return _prefs!.getString(_nameKey) ?? 'Usuario';
  }

  Future<void> saveUserAge(int age) async {
    await _prefs!.setInt(_ageKey, age);
  }

  int getUserAge() {
    return _prefs!.getInt(_ageKey) ?? 0;
  }

  Future<void> saveUserEmail(String email) async {
    await _prefs!.setString(_emailKey, email);
  }

  String getUserEmail() {
    return _prefs!.getString(_emailKey) ?? '';
  }

  Future<void> saveUserGoal(String goal) async {
    await _prefs!.setString(_goalKey, goal);
  }

  String getUserGoal() {
    return _prefs!.getString(_goalKey) ?? 'Sin objetivo definido';
  }

  // Métodos para peso
  Future<void> saveCurrentWeight(double weight) async {
    await _prefs!.setDouble(_currentWeightKey, weight);
  }

  double getCurrentWeight() {
    return _prefs!.getDouble(_currentWeightKey) ?? 70.0;
  }

  Future<void> saveTargetWeight(double weight) async {
    await _prefs!.setDouble(_targetWeightKey, weight);
  }

  double getTargetWeight() {
    return _prefs!.getDouble(_targetWeightKey) ?? 65.0;
  }

  // Métodos para progreso semanal
  Future<void> saveWeeklyProgress(List<double> progress) async {
    List<String> progressString = progress.map((e) => e.toString()).toList();
    await _prefs!.setStringList(_weeklyProgressKey, progressString);
  }

  List<double> getWeeklyProgress() {
    List<String>? progressString = _prefs!.getStringList(_weeklyProgressKey);
    if (progressString == null) return [70.0, 69.5, 69.0, 68.8, 68.5];
    return progressString.map((e) => double.parse(e)).toList();
  }

  // Método para limpiar todos los datos
  Future<void> clearAllData() async {
    await _prefs!.clear();
  }

  // Métodos para verificar si existen datos
  bool hasUserData() {
    return _prefs!.containsKey(_nameKey);
  }
}
