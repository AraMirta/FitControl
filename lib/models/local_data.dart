class Recipe {
  final String name;
  final String ingredients;
  final String day; // Ej: "Lunes"

  Recipe({required this.name, required this.ingredients, required this.day});
}

class Workout {
  final String name;
  final String duration;
  final String day;

  Workout({required this.name, required this.duration, required this.day});
}

class User {
  final String name;
  final double weight;
  final String goal; // "habitos", "ejercicio", "peso"

  User({required this.name, required this.weight, required this.goal});
}

// Datos de ejemplo: recetas
final List<Recipe> recipes = [
  Recipe(name: "Ensalada de quinoa", ingredients: "Quinoa, espinaca, tomate, aguacate", day: "Lunes"),
  Recipe(name: "Smoothie verde", ingredients: "Espinaca, plátano, leche de almendras", day: "Martes"),
  Recipe(name: "Bowl de avena", ingredients: "Avena, leche, frutos rojos, miel", day: "Miércoles"),
  Recipe(name: "Pollo al horno", ingredients: "Pechuga de pollo, limón, romero, papas", day: "Jueves"),
  Recipe(name: "Sopa de lentejas", ingredients: "Lentejas, zanahoria, cebolla, ajo", day: "Viernes"),
];
// Datos de ejemplo: entrenamientos
final List<Workout> workouts = [
  Workout(name: "Yoga matutino", duration: "20 mins", day: "Lunes"),
  Workout(name: "Cardio intenso", duration: "30 mins", day: "Martes"),
  Workout(name: "Pesas y resistencia", duration: "45 mins", day: "Miércoles"),
  Workout(name: "Pilates", duration: "30 mins", day: "Jueves"),
  Workout(name: "Estiramientos", duration: "15 mins", day: "Viernes"),
];