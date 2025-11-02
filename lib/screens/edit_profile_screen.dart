import 'package:flutter/material.dart';
import '../services/user_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controladores para cada campo
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _goalController = TextEditingController();
  UserPreferences? userPrefs;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userPrefs = await UserPreferences.getInstance();
    setState(() {
      _nameController.text = userPrefs!.getUserName();
      _ageController.text = userPrefs!.getUserAge().toString();
      _emailController.text = userPrefs!.getUserEmail();
      _goalController.text = userPrefs!.getUserGoal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Perfil')),
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
              onPressed: () async {
                // Guardar los datos en SharedPreferences
                await userPrefs!.saveUserName(_nameController.text);
                await userPrefs!.saveUserAge(
                  int.tryParse(_ageController.text) ?? 0,
                );
                await userPrefs!.saveUserEmail(_emailController.text);
                await userPrefs!.saveUserGoal(_goalController.text);

                // Mostrar mensaje de confirmación
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Perfil actualizado correctamente!'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(
                  context,
                  true,
                ); // Volver atrás indicando que se guardaron cambios
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
