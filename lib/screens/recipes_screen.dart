// lib/screens/recipes_screen.dart
import 'package:flutter/material.dart';
import '../models/local_data.dart';
import '../services/data_service.dart'; // Para guardar y actualizar recetas

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late List<Recipe> allRecipes;

  @override
  void initState() {
    super.initState();
    allRecipes = DataService.getAllRecipes(); // Obtener todas las recetas
  }

  // Agrupa recetas por día
  Map<String, List<Recipe>> _groupByDay() {
    final Map<String, List<Recipe>> map = {};
    for (var recipe in allRecipes) {
      map.putIfAbsent(recipe.day, () => []).add(recipe);
    }
    return map;
  }

  void _addOrEditRecipe({Recipe? existingRecipe}) {
    String selectedDay = existingRecipe?.day ?? "Lunes";
    String selectedTime = existingRecipe?.timeOfDay ?? "Mañana";
    String recipeName = existingRecipe?.name ?? "";
    String ingredientsText = existingRecipe != null
        ? existingRecipe.ingredients.join(", ")
        : "";

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existingRecipe != null ? "Editar receta" : "Agregar receta"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Selección de día
              DropdownButtonFormField<String>(
                value: selectedDay,
                decoration: const InputDecoration(labelText: "Día"),
                items: ["Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Domingo"]
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => selectedDay = v!,
              ),
              const SizedBox(height: 10),

              // Selección de horario
              DropdownButtonFormField<String>(
                value: selectedTime,
                decoration: const InputDecoration(labelText: "Horario"),
                items: ["Mañana", "Tarde", "Noche"]
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => selectedTime = v!,
              ),
              const SizedBox(height: 10),

              // Nombre de la receta
              TextFormField(
                initialValue: recipeName,
                decoration: const InputDecoration(labelText: "Nombre de receta"),
                onChanged: (v) => recipeName = v,
              ),
              const SizedBox(height: 10),

              // Ingredientes
              TextFormField(
                initialValue: ingredientsText,
                decoration: const InputDecoration(
                    labelText: "Ingredientes (separados por coma)"),
                onChanged: (v) => ingredientsText = v,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final ingredients = ingredientsText
                  .split(",")
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();

              final newRecipe = Recipe(
                day: selectedDay,
                timeOfDay: selectedTime,
                name: recipeName,
                ingredients: ingredients,
              );

              setState(() {
                if (existingRecipe != null) {
                  DataService.removeRecipe(existingRecipe);
                }
                DataService.addRecipe(newRecipe);
                allRecipes = DataService.getAllRecipes();
              });

              Navigator.pop(ctx);
            },
            child: Text(existingRecipe != null ? "Guardar" : "Agregar"),
          ),
        ],
      ),
    );
  }

  void _deleteRecipe(Recipe recipe) {
    setState(() {
      DataService.removeRecipe(recipe);
      allRecipes = DataService.getAllRecipes();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receta "${recipe.name}" eliminada.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipesByDay = _groupByDay();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recetas Saludables"),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color(0xFFF3E5F5),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditRecipe(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: recipesByDay.entries.map((entry) {
          final day = entry.key;
          final recipes = entry.value;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            child: ExpansionTile(
              title: Text(
                day,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: recipes.map((recipe) {
                return ListTile(
                  leading:
                      const Icon(Icons.restaurant_menu, color: Colors.deepPurple),
                  title: Text("${recipe.timeOfDay}: ${recipe.name}"),
                  subtitle:
                      Text("Ingredientes: ${recipe.ingredients.join(', ')}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _addOrEditRecipe(existingRecipe: recipe),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteRecipe(recipe),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
