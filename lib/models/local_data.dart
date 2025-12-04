class Workout {
  String name;
  int duration; // minutos
  
  Workout({required this.name, required this.duration});
}

class DayRoutine {
  String day;
  List<Workout> activities;

  DayRoutine({
    required this.day,
    required this.activities,
  });
}

class Recipe {
  String name;
  String day;
  String ingredients;

  Recipe({
    required this.name,
    required this.day,
    required this.ingredients,
  });
}
// Lista de actividades para seleccionar
final List<String> availableWorkouts = [
  "Cardio ligero",
  "Cardio intenso",
  "Fuerza tren superior",
  "Fuerza tren inferior",
  "Sentadillas",
  "Funcional",
  "Abdominales",
  "Yoga",
  "Estiramientos"
];

// Duraciones disponibles
final List<int> availableDurations = [5, 10, 15, 20, 25, 30];

// Rutinas de ejemplo
final List<DayRoutine> sampleDayRoutines = [
  DayRoutine(day: "Lunes", activities: [
    Workout(name: "Cardio intenso", duration: 20),
    Workout(name: "Abdominales", duration: 10),
  ]),
  DayRoutine(day: "Martes", activities: [
    Workout(name: "Fuerza tren inferior", duration: 25),
  ]),
  DayRoutine(day: "Miércoles", activities: [
    Workout(name: "Yoga", duration: 30),
  ]),
  DayRoutine(day: "Jueves", activities: [
    Workout(name: "Cardio ligero", duration: 15),
    Workout(name: "Estiramientos", duration: 10),
  ]),
  DayRoutine(day: "Viernes", activities: [
    Workout(name: "Fuerza tren superior", duration: 20),
    Workout(name: "Abdominales", duration: 10),
  ]),
  DayRoutine(day: "Sábado", activities: [
    Workout(name: "Funcional", duration: 25),
  ]),

];


//datos ejemplos de recetas.
final List<Recipe> sampleRecipes = [
  Recipe(name: "Ensalada de quinoa", ingredients: "Quinoa, espinaca, tomate, aguacate", day: "Lunes"),
  Recipe(name: "Smoothie verde", ingredients: "Espinaca, plátano, leche de almendras", day: "Martes"),
  Recipe(name: "Bowl de avena", ingredients: "Avena, leche, frutos rojos, miel", day: "Miércoles"),
  Recipe(name: "Pollo al horno", ingredients: "Pechuga de pollo, limón, romero, papas", day: "Jueves"),
  Recipe(name: "Sopa de lentejas", ingredients: "Lentejas, zanahoria, cebolla, ajo", day: "Viernes"),
];

