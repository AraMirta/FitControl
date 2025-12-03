import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import '../services/user_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Usuario';
  int userAge = 0;
  String userEmail = '';
  String userGoal = 'Sin objetivo definido';
  UserPreferences? userPrefs;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userPrefs = await UserPreferences.getInstance();
    setState(() {
      userName = userPrefs!.getUserName();
      userAge = userPrefs!.getUserAge();
      userEmail = userPrefs!.getUserEmail();
      userGoal = userPrefs!.getUserGoal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF4CAF50); // Verde principal

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFA), // Verde muy claro (menta)
      appBar: AppBar(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: const Text('Mi Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Foto de perfil
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                'assets/images/perfil.png',
              ), // Asegurate de agregar esta imagen
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 20),

            // Tarjeta de datos personales
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    infoRow(
                      Icons.person,
                      'Nombre',
                      userName.isEmpty ? 'Jane Doe' : userName,
                    ),
                    const Divider(),
                    infoRow(
                      Icons.cake,
                      'Edad',
                      userAge > 0 ? userAge.toString() : '0',
                    ),
                    const Divider(),
                    infoRow(
                      Icons.email,
                      'Email',
                      userEmail.isEmpty ? 'usuario@dominio.com' : userEmail,
                    ),
                    const Divider(),
                    infoRow(
                      Icons.flag,
                      'Objetivo',
                      userGoal.isEmpty
                          ? 'Ej: Bajar 5 kg en 2 meses '
                          : userGoal,
                      color: Colors.green.shade700,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(),
                  ),
                );
                if (result == true) {
                  // Recargar datos si se guardaron cambios
                  _loadUserData();
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text('Editar perfil'),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String label, String value, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color ?? Colors.black54),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 16, color: color ?? Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
