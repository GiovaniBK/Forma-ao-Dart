import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:apf6_funcoes/main.dart';

void main() {
  testWidgets('abre a tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Ver pessoas cadastradas'), findsOneWidget);
    expect(find.text('Incluir pessoa'), findsOneWidget);
  });
}
