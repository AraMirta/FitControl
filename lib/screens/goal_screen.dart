import 'package:flutter/material.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Elige tu objetivo")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildGoalCard(
            context,
            title: "Hábitos Saludables",
            icon: Icons.restaurant,
            description: "Plan de comidas semanal",
            route: '/recipes',
          ),
          _buildGoalCard(
            context,
            title: "Rutinas de Ejercicio",
            icon: Icons.fitness_center,
            description: "Ejercicios por día",
            route: '/workouts',
          ),
          _buildGoalCard(
            context,
            title: "Perder Peso",
            icon: Icons.monitor_weight,
            description: "Seguimiento de progreso",
            route: '/weight',
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, {required String title, required IconData icon, required String description, required String route}) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}