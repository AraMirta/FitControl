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

class Recipe {
  final String day;        // Lunes, Martes, etc.
  final String meal;       // Desayuno, Almuerzo, Cena
  final String name;       // Nombre de la receta
  final List<String> ingredients; // Lista de ingredientes

  Recipe({
    required this.day,
    required this.meal,
    required this.name,
    required this.ingredients,
  });
}

// Lista de recetas saludables predefinidas
final List<Recipe> sampleRecipes = [
  // Lunes
  Recipe(
    day: "Lunes",
    meal: "Desayuno",
    name: "Avena con frutas",
    ingredients: ["Avena", "Banana", "Manzana", "Leche de soja"],
  ),
  Recipe(
    day: "Lunes",
    meal: "Desayuno",
    name: "Yogur con cereales",
    ingredients: ["Yogur natural", "Cereales integrales", "Frutas"],
  ),
  Recipe(
    day: "Lunes",
    meal: "Almuerzo",
    name: "Pollo con ensalada",
    ingredients: ["Pechuga de pollo", "Lechuga", "Tomate", "Arroz integral"],
  ),
  Recipe(
    day: "Lunes",
    meal: "Cena",
    name: "Sopa de verduras",
    ingredients: ["Zanahoria", "Zapallo", "Apio", "Caldo de verduras"],
  ),
  // Martes (ejemplo)
  Recipe(
    day: "Martes",
    meal: "Desayuno",
    name: "Pan integral con palta",
    ingredients: ["Pan integral", "Palta", "Tomate"],
  ),
  Recipe(
    day: "Martes",
    meal: "Almuerzo",
    name: "Arroz con pollo y verduras",
    ingredients: ["Arroz integral", "Pechuga de pollo", "Zapallo", "Zanahoria"],
  ),
  Recipe(
    day: "Martes",
    meal: "Cena",
    name: "Ensalada de atún",
    ingredients: ["Atún", "Lechuga", "Tomate", "Huevo duro"],
  ),
  //miercoles
  Recipe(
    day: "Miércoles",
    meal: "Desayuno",
    name: "Smoothie verde",
    ingredients: ["Espinaca", "Banana", "Manzana", "Leche de almendra"],
  ),
  Recipe(
    day: "Miércoles",
    meal: "Almuerzo",
    name: "Quinoa con verduras",
    ingredients: ["Quinoa", "Zanahoria", "Zapallo", "Garbanzos"],
  ),
  Recipe(
    day: "Miércoles",
    meal: "Cena",
    name: "Tortilla de espinaca",
    ingredients: ["Huevos", "Espinaca", "Cebolla", "Queso rallado"],
  ),
  //jueves
  Recipe(
    day: "Jueves",
    meal: "Desayuno",
    name: "Tostadas integrales con mermelada",
    ingredients: ["Pan integral", "Mermelada sin azúcar"],
  ),
  Recipe(
    day: "Jueves",
    meal: "Almuerzo",
    name: "Pasta integral con salsa de tomate",
    ingredients: ["Pasta integral", "Tomate", "Albahaca", "Queso parmesano"],
  ),
  Recipe(
    day: "Jueves",
    meal: "Cena",
    name: "Ensalada César",
    ingredients: ["Lechuga", "Pollo a la plancha", "Queso parmesano", "Aderezo César"],
  ),
  //viernes
  Recipe(
    day: "Viernes",
    meal: "Desayuno",
    name: "Huevos revueltos con tomate",
    ingredients: ["Huevos", "Tomate", "Cebolla", "Pan integral"],
  ),
  Recipe(
    day: "Viernes",
    meal: "Almuerzo",
    name: "Hamburguesa de pavo",
    ingredients: ["Carne de pavo", "Pan integral", "Lechuga", "Tomate"],
  ),
  Recipe(
    day: "Viernes",
    meal: "Cena",
    name: "Pescado al horno con verduras",
    ingredients: ["Filete de pescado", "Zanahoria", "Zapallo", "Brócoli"],
  ),
  //sábado
  Recipe(
    day: "Sábado",
    meal: "Desayuno",
    name: "Panqueques integrales",
    ingredients: ["Harina integral", "Huevo", "Leche de almendra", "Miel"],
  ),
  Recipe(
    day: "Sábado",
    meal: "Almuerzo",
    name: "Ensalada de quinoa",
    ingredients: ["Quinoa", "Tomate", "Pepino", "Aceitunas"],
  ),
  Recipe(
    day: "Sábado",
    meal: "Cena",
    name: "Pizza casera saludable",
    ingredients: ["Masa integral", "Salsa de tomate", "Queso bajo en grasa", "Vegetales"],
  ),


  
];

