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
  String _ageError = '';
  String _nameError = '';
  String _emailError = '';
  int? _selectedAge;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _nameController.addListener(_validateName);
    _emailController.addListener(_validateEmail);
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
      if (_selectedAge != null) {
        final age = _selectedAge!;
        if (age < 18) {
          _ageError = 'La edad debe ser mayor a 18 ';
        } else {
          _ageError = '';
        }
      } else {
        _ageError = '';
      }
    });
  }

  void _validateEmail() {
    setState(() {
      final text = _emailController.text.trim();
      // Email is optional: no error when empty
      if (text.isEmpty) {
        _emailError = '';
        return;
      }
      // Simple regex: something@something.suffix (suffix at least 2 chars)
      final emailReg = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]{2,}");
      if (!emailReg.hasMatch(text)) {
        _emailError = 'Formato de email no válido';
      } else {
        _emailError = '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_validateName);
    _emailController.removeListener(_validateEmail);
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
      final a = userPrefs!.getUserAge();
      _selectedAge = a > 0 ? a : null;
      _ageController.text = _selectedAge?.toString() ?? '';
      _emailController.text = userPrefs!.getUserEmail();
      _goalController.text = userPrefs!.getUserGoal();
      // validate fields after loading
      _validateName();
      _validateAge();
      _validateEmail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Perfil')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          final content = Padding(
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
                DropdownButtonFormField<int>(
                  value: _selectedAge,
                  decoration: InputDecoration(
                    labelText: 'Edad',
                    errorText: _ageError.isNotEmpty ? _ageError : null,
                  ),
                  items:
                      List.generate(99, (i) => i + 1)
                          .map(
                            (age) => DropdownMenuItem<int>(
                              value: age,
                              child: Text(age.toString()),
                            ),
                          )
                          .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedAge = val;
                      _ageController.text = val?.toString() ?? '';
                      _validateAge();
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _emailError.isNotEmpty ? _emailError : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _goalController,
                  decoration: InputDecoration(labelText: 'Objetivo'),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed:
                        _ageError.isEmpty &&
                          _nameError.isEmpty &&
                          _emailError.isEmpty &&
                          _selectedAge != null &&
                          _nameController.text.isNotEmpty
                          ? () async {
                            // Guardar los datos en SharedPreferences
                            await userPrefs!.saveUserName(_nameController.text);
                            await userPrefs!.saveUserAge(_selectedAge ?? 0);
                            await userPrefs!.saveUserEmail(
                              _emailController.text,
                            );
                            await userPrefs!.saveUserGoal(_goalController.text);

                            // Mostrar mensaje de confirmación
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    '¡Perfil actualizado correctamente!',
                                  ),
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
          );

          return isWide
              ? Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 700),
                  child: content,
                ),
              )
              : content;
        },
      ),
    );
  }
}
