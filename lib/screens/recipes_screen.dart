import 'package:flutter/material.dart';
import '../models/local_data.dart'; // Importa los datos

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Lavanda
      appBar: AppBar(title: const Text("Recetas Saludables"), backgroundColor: Colors.deepPurple, ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (ctx, index) {
          final recipe = recipes[index];

           return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: const Icon(Icons.restaurant_menu, color: Colors.deepPurple, size: 30),
              title: Text(
                recipe.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                "Día: ${recipe.day}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text(recipe.name),
                    content: Text("Ingredientes:\n${recipe.ingredients}"),
                    actions: [
                      TextButton(
                        child: const Text("Cerrar"),
                         onPressed: () => Navigator.of(ctx).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}