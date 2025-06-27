// lib/screens/weight_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  // Datos de ejemplo (simulados)
  double currentWeight = 70.0; // Peso actual
  double goalWeight = 60.0;    // Meta
  List<double> weeklyProgress = [70.0, 68.5, 67.0, 65.5, 64.0, 63.0, 62.0]; // Progreso semanal

  @override
  Widget build(BuildContext context) {
    double progressPercentage = ((currentWeight - goalWeight) / (weeklyProgress.first - goalWeight)) * 100;

    var lineChartBarData2 = LineChartBarData(
                      spots: weeklyProgress.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value);
                      }).toList(),
                      isCurved: true,
                      color: const Color.fromARGB(255, 94, 191, 116),
                      dotData: FlDotData(show: true),
                    );
    var lineChartBarData = lineChartBarData2;
    return Scaffold(
      appBar: AppBar(title: Text("Progreso de Peso")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tarjeta de resumen
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Tu progreso", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progressPercentage / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 20,
                    ),
                    SizedBox(height: 10),
                    Text("${progressPercentage.toStringAsFixed(1)}% hacia tu meta"),
                    Text("${currentWeight.toStringAsFixed(1)} kg / ${goalWeight.toStringAsFixed(1)} kg"),
                  ],
                ),
              ),
            ),

            // Gráfico de progreso
            SizedBox(height: 20),
            Text("Evolución semanal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 6,
                  minY: goalWeight - 2,
                  maxY: weeklyProgress.first + 2,
                  lineBarsData: [
                    lineChartBarData,
                  ],
                ),
              ),
            ),

            // Botón para actualizar peso
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Actualizar mi peso"),
              onPressed: () => _showUpdateWeightDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateWeightDialog(BuildContext context) {
    TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Actualizar peso"),
        content: TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: "Nuevo peso (kg)"),
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text("Guardar"),
            onPressed: () {
              if (weightController.text.isNotEmpty) {
                setState(() {
                  currentWeight = double.parse(weightController.text);
                  weeklyProgress.add(currentWeight); // Añade el nuevo peso al progreso
                });
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}