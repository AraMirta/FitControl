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
  String name;        // Nombre de la receta
  String day;         // Día de la semana
  String timeOfDay;   // Mañana, tarde, noche
  List<String> ingredients; // Ingredientes

  Recipe({
    required this.name,
    required this.day,
    required this.timeOfDay,
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
  "Estiramientos",
  "Correr",
  "Caminar",
  "Nadar",
  "Ciclismo",
  "flexiones"

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
  Recipe(
    name: "Avena con frutas",
    day: "Lunes",
    timeOfDay: "Mañana",
    ingredients: ["Avena", "Leche", "Banana", "Frutos rojos"],
  ),
  Recipe(
    name: "Ensalada de pollo",
    day: "Lunes",
    timeOfDay: "Almuerzo",
    ingredients: ["Pollo", "Lechuga", "Tomate", "Aceite de oliva"],
  ),
  Recipe(
    name: "Yogur con nueces",
    day: "Lunes",
    timeOfDay: "Merienda",
    ingredients: ["Yogur natural", "Nueces", "Miel"],
  ),
  // Repetir para otros días y horarios
];
final List<String> daysOfWeek = [
  "Lunes",
  "Martes",
  "Miércoles",
  "Jueves",
  "Viernes",
  "Sábado",
  "Domingo",
];