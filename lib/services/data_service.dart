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
  static final List<String> daysOfWeek = [
    "Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"
  ];

  static final List<String> mealTypes = ["Desayuno","Almuerzo","Cena"];

  // Lista interna de recetas seleccionadas por el usuario
  // Copia de todas las recetas
  static final List<Recipe> _recipes = List<Recipe>.from(sampleRecipes);

  // Devuelve todas las recetas
  static List<Recipe> getAllRecipes() => List<Recipe>.from(_recipes);

  // Devuelve recetas filtradas por día y comida
  static List<Recipe> getRecipesByDayAndMeal(String day, String meal) {
    return _recipes.where((r) => r.day == day && r.meal == meal).toList();
  }

  // Agrega una receta seleccionada (si luego quieres guardar selección)
  static void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
  }

  // Elimina receta
  static void removeRecipe(Recipe recipe) {
    _recipes.remove(recipe);
  }
}


