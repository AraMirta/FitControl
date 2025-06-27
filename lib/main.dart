import 'package:fitcontrol/screens/calendar_screen.dart';
import 'package:fitcontrol/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/goal_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/workouts_screen.dart';
import 'screens/weight_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(FitControlApp()); //Crea la app FitControlApp
}

class FitControlApp extends StatelessWidget {
  const FitControlApp({super.key});
  @override
  Widget build(BuildContext context) { //build construye la interfaz visual.
    return MaterialApp( // es el widget raíz de la app, y define:titulo,tema, pantalla ppal.
      initialRoute: '/',// pantalla principal
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/goal': (context) => const GoalScreen(),
        '/main': (context) => const MainScreen(),
        '/recipes': (context) => const RecipesScreen(),
        '/workouts': (context) => const WorkoutsScreen(), // Pantalla de ejercicios (similar a recipes)
        '/weight': (context) => const WeightScreen(), // Pantalla de peso 
        '/profile': (context) => const ProfileScreen(), 
        '/calendar': (context) => const CalendarScreen(),
      },
      title: 'FitControl',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {//pantalla inicial (HomeScreen) con un título y un mensaje.
 const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FitControl'),
      ),
      body: Center(
        child: Text(
          'Bienvenid@s a FitControl 👋',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}