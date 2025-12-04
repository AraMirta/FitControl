// lib/screens/recipes_screen.dart
import 'package:flutter/material.dart';
import '../models/local_data.dart';
import '../services/data_service.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final List<String> daysOfWeek = ["Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"];
  final List<String> meals = ["Desayuno","Almuerzo","Cena"];

  // Map para guardar la receta seleccionada por día y comida
  final Map<String, Map<String, Recipe?>> selectedRecipes = {};

  @override
  void initState() {
    super.initState();
    for (var day in daysOfWeek) {
      selectedRecipes[day] = {};
      for (var meal in meals) {
        selectedRecipes[day]![meal] = null;
      }
    }
  }

  void _selectRecipe(String day, String meal) async {
    final recipes = DataService.getRecipesByDayAndMeal(day, meal);

    Recipe? chosen = await showDialog<Recipe>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Seleccionar $meal de $day"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: recipes.map((r) {
              return ListTile(
                title: Text(r.name),
                subtitle: Text("Ingredientes: ${r.ingredients.join(', ')}"),
                onTap: () => Navigator.pop(ctx, r),
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (chosen != null) {
      setState(() {
        selectedRecipes[day]![meal] = chosen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recetas Saludables"),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color(0xFFF3E5F5),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: daysOfWeek.map((day) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ExpansionTile(
              title: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              children: meals.map((meal) {
                final selected = selectedRecipes[day]![meal];
                return ListTile(
                  title: Text(meal),
                  subtitle: selected != null
                      ? Text("${selected.name}\nIngredientes: ${selected.ingredients.join(', ')}")
                      : const Text("Seleccioná receta"),
                  trailing: ElevatedButton(
                    onPressed: () => _selectRecipe(day, meal),
                    child: const Text("Elegir"),
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

