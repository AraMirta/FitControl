// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:fitcontrol/main.dart';

void main() {
  testWidgets('FitControl app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FitControlApp());

    // Verify that our app loads correctly with welcome screen
    expect(find.text('Bienvenid@s a FitControl'), findsOneWidget);
    expect(find.text('Ir a pantalla principal'), findsOneWidget);
    expect(find.text('Ver perfil'), findsOneWidget);

    // Tap the main screen button and trigger navigation
    await tester.tap(find.text('Ir a pantalla principal'));
    await tester.pumpAndSettle();

    // Verify that we navigated to main screen
    expect(find.text('Recetas Semanales'), findsOneWidget);
  });
}
