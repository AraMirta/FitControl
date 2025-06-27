import 'package:flutter/material.dart';
import '../models/local_data.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  IconData getWorkoutIcon(String name) {
    if (name.toLowerCase().contains('yoga')) return Icons.self_improvement;
    if (name.toLowerCase().contains('cardio')) return Icons.directions_run;
    if (name.toLowerCase().contains('pesas')) return Icons.fitness_center;
    if (name.toLowerCase().contains('pilates')) return Icons.accessibility_new;
    if (name.toLowerCase().contains('estiramiento')) return Icons.accessibility;
    return Icons.sports;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rutinas Semanales"),
        leading: BackButton(),
        backgroundColor: Colors.purple.shade200,
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (ctx, index) {
          final workout = workouts[index];
          return Card(
            color: Colors.purple.shade50,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.purple.shade100,
                child: Icon(
                  getWorkoutIcon(workout.name),
                  color: Colors.purple.shade800,
                  size: 28,
                ),
              ),
              title: Text(
                workout.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                "⏱ ${workout.duration}   |   📅 ${workout.day}",
                style: TextStyle(color: Colors.grey.shade700),
              ),
              onTap: () {
                // Mostrar detalle o animación futura
              },
            ),
          );
        },
      ),
    );
  }
}
