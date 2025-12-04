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
      filteredRoutines = dayRoutines.map((r) {
        final activities = r.activities.where((a) =>
            a.name.toLowerCase().contains(query)).toList();
        return DayRoutine(day: r.day, activities: activities);
      }).where((r) => r.activities.isNotEmpty).toList();
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ExpansionTile(
              title: Text(dayRoutine.day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      // Lista de actividades del día
                      ...List.generate(dayRoutine.activities.length, (index) {
                        final a = dayRoutine.activities[index];
                        return Dismissible(
                          key: Key('${dayRoutine.day}_${a.name}_$index'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(Icons.delete_forever, color: Colors.white),
                          ),
                          onDismissed: (_) {
                            setState(() {
                              DataService.removeActivity(dayRoutine.day, a);
                              dayRoutines = DataService.getAll();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Actividad "${a.name}" eliminada.')));
                          },
                          child: CheckboxListTile(
                            value: false, // si querés marcar completada, podés agregar propiedad en Workout
                            onChanged: (val) {
                              // Por ahora solo visual; si querés persistir 'completada', agregamos atributo en Workout
                            },
                            title: Text('${a.name}'),
                            subtitle: Text('${a.duration}'),
                            secondary: Icon(_getWorkoutIcon(a.name)),
                          ),
                        );
                      }),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => _onAddActivityPressed(dayRoutine.day),
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar actividad'),
                        ),
                      ),
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
    if (n.contains('pesas') || n.contains('resistencia')) return Icons.fitness_center;
    if (n.contains('pilates')) return Icons.accessibility_new;
    if (n.contains('estirami')) return Icons.accessibility;
    return Icons.sports;
  }


  void _onAddActivityPressed(String day) {
    final nameCtrl = TextEditingController();
    final durCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar actividad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: durCtrl, decoration: const InputDecoration(labelText: 'Duración (ej: 20 mins)'), keyboardType: TextInputType.text),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final nombre = nameCtrl.text.trim();
              final dur = durCtrl.text.trim();
              if (nombre.isNotEmpty) {
                final newWorkout = Workout(name: nombre, duration: dur, day: day);
                setState(() {
                  DataService.addActivity(day, newWorkout);
                  dayRoutines = DataService.getAll();
                  _filterRoutines(); // <-- refresca el filtro

                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}


