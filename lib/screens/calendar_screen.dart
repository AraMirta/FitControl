import 'package:fitcontrol/models/local_data.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
 // trae recetas y workouts

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();// dia actual centrado
  DateTime? _selectedDay; //dia seleccionado por usuario

  // Esta función busca eventos según el día seleccionado
  List<String> getEventsForDay(DateTime day) {
    String dayName = _getDayName(day.weekday);

    List<String> events = [];

     // Buscamos la rutina del día
      DayRoutine? routine = sampleDayRoutines.firstWhere(
        (r) => r.day == dayName,
        orElse: () => DayRoutine(day: dayName, activities: []),
      );
      // Cargamos sus actividades
      events.addAll(
        routine.activities.map((w) => "🏋️ ${w.name} (${w.duration} min)")
      );
    return events;
  }

  String _getDayName(int weekday) {
    const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    if (weekday < 1 || weekday > 7) return 'Desconocido';
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendario Saludable')),
      body: Column(

        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Eventos para: ${_getDayName((_selectedDay ?? _focusedDay).weekday)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
             child: selectedEvents.isEmpty
                ? Center(child: Text('📭 No hay recetas ni ejercicios para este día.'))
                : ListView(
                     children: selectedEvents.map((e) => ListTile(title: Text(e))).toList(),
                  ),
          )
        ],
      ),
    );
  }
}
