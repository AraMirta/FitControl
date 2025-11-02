import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitcontrol/main.dart';
import 'package:fitcontrol/screens/welcome_screen.dart';
import 'package:fitcontrol/screens/main_screen.dart';

void main() {
  group('Navigation Tests (Functional Testing)', () {
    testWidgets('Should navigate from Welcome to Main screen', (
      WidgetTester tester,
    ) async {
      // Construir la app
      await tester.pumpWidget(const FitControlApp());

      // Verificar que estamos en la pantalla de bienvenida
      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.text('Bienvenid@s a FitControl'), findsOneWidget);

      // Buscar y tocar el botón "Ir a pantalla principal"
      final mainButton = find.text('Ir a pantalla principal');
      expect(mainButton, findsOneWidget);

      await tester.tap(mainButton);
      await tester.pumpAndSettle(); // Esperar que termine la navegación

      // Verificar que navegamos exitosamente a MainScreen
      expect(find.byType(MainScreen), findsOneWidget);
      expect(
        find.text('Recetas Semanales'),
        findsOneWidget,
      ); // Título por defecto
    });

    testWidgets('Should have navigation buttons available', (
      WidgetTester tester,
    ) async {
      // Construir la app
      await tester.pumpWidget(const FitControlApp());

      // Verificar que estamos en welcome screen
      expect(find.byType(WelcomeScreen), findsOneWidget);

      // Verificar que ambos botones de navegación están presentes
      expect(find.text('Ir a pantalla principal'), findsOneWidget);
      expect(find.text('Ver perfil'), findsOneWidget);

      // Verificar que los botones son funcionales (tienen onPressed)
      final mainButton = find.ancestor(
        of: find.text('Ir a pantalla principal'),
        matching: find.byType(ElevatedButton),
      );
      final profileButton = find.ancestor(
        of: find.text('Ver perfil'),
        matching: find.byType(ElevatedButton),
      );

      expect(tester.widget<ElevatedButton>(mainButton).onPressed, isNotNull);
      expect(tester.widget<ElevatedButton>(profileButton).onPressed, isNotNull);
    });

    testWidgets('Should have correct initial route', (
      WidgetTester tester,
    ) async {
      // Construir la app
      await tester.pumpWidget(const FitControlApp());

      // Verificar que la ruta inicial es WelcomeScreen
      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(
        find.text('🍃 FitControl: ¡Plan para una vida Saludable! 💪'),
        findsOneWidget,
      );
    });
  });
}
