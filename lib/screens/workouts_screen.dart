// lib/screens/workouts_screen.dart
import 'package:flutter/material.dart';
import '../models/local_data.dart';
import '../services/data_service.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late List<DayRoutine> dayRoutines;
  TextEditingController searchCtrl = TextEditingController();
  List<DayRoutine> filteredRoutines = [];

  // Lista fija de ejercicios predefinidos
  final List<String> availableWorkouts= [
    "Sentadillas",
    "Abdominales",
    "Funcional",
    "Cardio ligero",
    "Cardio intenso",
    "Fuerza tren superior",
    "Fuerza tren inferior",
    "Yoga",
    "Estiramientos",
    "Correr",
    "Caminar",
    "Nadar",
    "ciclismo",
    "flexiones"

  ];

  // Duración fija
  final List<int> availableDurations = [30, 45, 60, 90, 120];

  @override
  void initState() {
    super.initState();
    dayRoutines = DataService.getAll();
    filteredRoutines = dayRoutines;
    searchCtrl.addListener(_filterRoutines);
  }

  void _filterRoutines() {
    final query = searchCtrl.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredRoutines = dayRoutines;
      } else {
        filteredRoutines = dayRoutines
            .map((r) {
              final activities = r.activities
                  .where((a) => a.name.toLowerCase().contains(query))
                  .toList();
              return DayRoutine(day: r.day, activities: activities);
            })
            .where((r) => r.activities.isNotEmpty)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rutinas Semanales"),
        backgroundColor: Colors.purple.shade200,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Buscar actividad...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: filteredRoutines.length,
        itemBuilder: (context, dayIndex) {
          final dayRoutine = filteredRoutines[dayIndex];

          return Card(
            color: Colors.purple.shade50,
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ExpansionTile(
              title: Text(
                dayRoutine.day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      // Lista de actividades
                      ...List.generate(dayRoutine.activities.length, (index) {
                        final a = dayRoutine.activities[index];
                        return ListTile(
                          leading: Icon(_getWorkoutIcon(a.name)),
                          title: Text(a.name),
                          subtitle: Text("${a.duration} minutos"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _onEditActivityPressed(dayRoutine.day, a),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _deleteActivity(dayRoutine.day, a),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () =>
                              _onAddActivityPressed(dayRoutine.day),
                          icon: const Icon(Icons.add),
                          label: const Text("Agregar actividad"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getWorkoutIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('yoga')) return Icons.self_improvement;
    if (n.contains('cardio')) return Icons.directions_run;
    if (n.contains('pesas') || n.contains('resistencia'))
      return Icons.fitness_center;
    if (n.contains('funcional')) return Icons.sports_gymnastics;
    if (n.contains('hiit')) return Icons.flash_on;
    return Icons.sports;
  }

  // -----------------------------
  //   AGREGAR ACTIVIDAD
  // -----------------------------

  void _onAddActivityPressed(String day) {
    String? selectedExercise = availableWorkouts.first;
    int? selectedDuration = availableDurations.first;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Agregar actividad"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedExercise,
              decoration: const InputDecoration(labelText: "Ejercicio"),
              items: availableWorkouts
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => selectedExercise = v,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: selectedDuration,
              decoration: const InputDecoration(labelText: "Duración (minutos)"),
              items: availableDurations
                  .map((d) => DropdownMenuItem(value: d, child: Text("$d min")))
                  .toList(),
              onChanged: (v) => selectedDuration = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final newWorkout = Workout(
                name: selectedExercise!,
                duration: selectedDuration!,
                
              );

              setState(() {
                DataService.addActivity(day, newWorkout);
                dayRoutines = DataService.getAll();
                _filterRoutines();
              });

              Navigator.pop(ctx);
            },
            child: const Text("Agregar"),
          ),
        ],
      ),
    );
  }

  // -----------------------------
  //   EDITAR ACTIVIDAD
  // -----------------------------

  void _onEditActivityPressed(String day, Workout activity) {
    String selectedExercise = activity.name;
    int selectedDuration = activity.duration;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Editar actividad"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedExercise,
              decoration: const InputDecoration(labelText: "Ejercicio"),
              items: availableWorkouts
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => selectedExercise = v!,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<int>(
              value: selectedDuration,
              decoration: const InputDecoration(labelText: "Duración (minutos)"),
              items: availableDurations
                  .map((d) =>
                      DropdownMenuItem(value: d, child: Text("$d min")))
                  .toList(),
              onChanged: (v) => selectedDuration = v!,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              DataService.removeActivity(day, activity);
              DataService.addActivity(
                day,
                Workout(
                  name: selectedExercise,
                  duration: selectedDuration,
                
                ),
              );

              setState(() {
                dayRoutines = DataService.getAll();
                _filterRoutines();
              });

              Navigator.pop(ctx);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  // -----------------------------
  //   ELIMINAR ACTIVIDAD
  // -----------------------------

  void _deleteActivity(String day, Workout a) {
    setState(() {
      DataService.removeActivity(day, a);
      dayRoutines = DataService.getAll();
      _filterRoutines();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Actividad "${a.name}" eliminada.')),
    );
  }
}
