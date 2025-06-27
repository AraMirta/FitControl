import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controladores para cada campo
  final _nameController = TextEditingController(text: 'Arabel Mirta');
  final _ageController = TextEditingController(text: '40');
  final _emailController = TextEditingController(text: 'arabelmirta@gmail.com');
  final _goalController = TextEditingController(
    text: 'Comer saludable, tener hábitos de ejercicios, bajar de peso (4kg)',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Edad'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(labelText: 'Objetivo'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Por ahora solo mostramos los cambios por consola
                print('Nombre: ${_nameController.text}');
                print('Edad: ${_ageController.text}');
                print('Email: ${_emailController.text}');
                print('Objetivo: ${_goalController.text}');
                Navigator.pop(context); // Volver atrás
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
