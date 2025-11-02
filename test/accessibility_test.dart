import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitcontrol/main.dart';
import 'package:fitcontrol/screens/welcome_screen.dart';

void main() {
  group('Accessibility Tests (Usability Testing)', () {
    testWidgets('All buttons should have accessible labels', (
      WidgetTester tester,
    ) async {
      // Construir la app
      await tester.pumpWidget(const FitControlApp());

      // Verificar que todos los botones tienen texto visible
      final buttons = find.byType(ElevatedButton);
      expect(buttons, findsAtLeastNWidgets(1));

      // Verificar que cada botón tiene contenido de texto
      for (int i = 0; i < buttons.evaluate().length; i++) {
        final button = buttons.at(i);
        final buttonWidget = tester.widget<ElevatedButton>(button);

        // Verificar que el botón tiene un child (texto)
        expect(buttonWidget.child, isNotNull);

        // Verificar que es un widget Text
        expect(buttonWidget.child, isA<Text>());

        final textWidget = buttonWidget.child as Text;
        expect(textWidget.data, isNotNull);
        expect(textWidget.data!.isNotEmpty, isTrue);
      }
    });

    testWidgets('App should have proper contrast and readability', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const FitControlApp());

      // Verificar que los textos principales son visibles
      expect(find.text('Bienvenid@s a FitControl'), findsOneWidget);
      expect(
        find.text('🍃 FitControl: ¡Plan para una vida Saludable! 💪'),
        findsOneWidget,
      );

      // Verificar que los botones son suficientemente grandes (mínimo 44x44)
      final buttons = find.byType(ElevatedButton);
      for (int i = 0; i < buttons.evaluate().length; i++) {
        final button = buttons.at(i);
        final size = tester.getSize(button);

        // Verificar tamaño mínimo recomendado para accesibilidad
        expect(size.height, greaterThanOrEqualTo(44.0));
      }
    });

    testWidgets('Navigation should be intuitive (Tree Testing)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const FitControlApp());

      // Test de árbol de navegación - verificar estructura lógica

      // 1. Pantalla inicial debe ser clara
      expect(find.byType(WelcomeScreen), findsOneWidget);

      // 2. Debe tener opciones claras de navegación
      expect(find.text('Ir a pantalla principal'), findsOneWidget);
      expect(find.text('Ver perfil'), findsOneWidget);

      // 3. Los botones deben estar claramente diferenciados
      final mainButton = find.text('Ir a pantalla principal');
      final profileButton = find.text('Ver perfil');

      // Verificar que ambos botones son alcanzables
      expect(
        tester
            .widget<ElevatedButton>(
              find.ancestor(
                of: mainButton,
                matching: find.byType(ElevatedButton),
              ),
            )
            .onPressed,
        isNotNull,
      );

      expect(
        tester
            .widget<ElevatedButton>(
              find.ancestor(
                of: profileButton,
                matching: find.byType(ElevatedButton),
              ),
            )
            .onPressed,
        isNotNull,
      );
    });

    testWidgets('Text should be readable and well-sized', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const FitControlApp());

      // Verificar tamaños de fuente adecuados
      final titleText = find.text('Bienvenid@s a FitControl');
      final titleWidget = tester.widget<Text>(titleText);

      // Título debe tener tamaño adecuado (>= 18)
      expect(titleWidget.style?.fontSize, greaterThanOrEqualTo(18.0));

      // Verificar que hay contraste (texto blanco sobre fondo oscuro)
      expect(titleWidget.style?.color, equals(Colors.white));
    });
  });
}
