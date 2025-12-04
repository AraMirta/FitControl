import '../models/local_data.dart';

class DataService {
  static List<DayRoutine> getAll() => sampleDayRoutines;

  
  static void addActivity(String day, Workout a) {
    final r = sampleDayRoutines.firstWhere((d) => d.day == day);
    r.activities.add(a);
  }


  static void removeActivity(String day, Workout workout) {
  // Buscamos la rutina del día correspondiente
  final routine = sampleDayRoutines.firstWhere(
    (r) => r.day == day,
    orElse: () => DayRoutine(day: day, activities:[]),
  );

  // Eliminamos la actividad exacta
  routine.activities.removeWhere(
    (a) => a.name == workout.name && a.duration == workout.duration
  );
}

}
