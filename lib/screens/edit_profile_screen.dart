import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _ageError = '';
  String _nameError = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _ageController.addListener(_validateAge);
    _nameController.addListener(_validateName);
  }

  void _validateName() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _nameError = 'El nombre no puede quedar vacío';
      } else if (_nameController.text.length < 3) {
        _nameError = 'El nombre debe tener al menos 3 caracteres';
      } else {
        _nameError = '';
      }
    });
  }

  void _validateAge() {
    setState(() {
      if (_ageController.text.isNotEmpty) {
        int? age = int.tryParse(_ageController.text);
        if (age == null) {
          _ageError = 'Formato no válido';
        } else if (age < 18) {
          _ageError = 'La edad debe ser mayor a 18 ';
        } else {
          _ageError = '';
        }
      } else {
        _ageError = '';
      }
    });
  }

  @override
  void dispose() {
    _ageController.removeListener(_validateAge);
    _nameController.removeListener(_validateName);
    _ageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _goalController.dispose();
    super.dispose();
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
              decoration: InputDecoration(
                labelText: 'Nombre',
                errorText: _nameError.isNotEmpty ? _nameError : null,
              ),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Edad',
                errorText: _ageError.isNotEmpty ? _ageError : null,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              onPressed: _ageError.isEmpty && 
                         _nameError.isEmpty && 
                         _ageController.text.isNotEmpty &&
                         _nameController.text.isNotEmpty
                  ? () async {
                      // Guardar los datos en SharedPreferences
                      await userPrefs!.saveUserName(_nameController.text);
                      await userPrefs!.saveUserAge(
                        int.tryParse(_ageController.text) ?? 0,
                      );
                      await userPrefs!.saveUserEmail(_emailController.text);
                      await userPrefs!.saveUserGoal(_goalController.text);

                      // Mostrar mensaje de confirmación
                      if (context.mounted) {
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
                      }
                    }
                  : null,
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
