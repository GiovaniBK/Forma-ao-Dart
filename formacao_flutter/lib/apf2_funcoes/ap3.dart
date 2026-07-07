import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color cor = Colors.white;
  final random = Random();

  BoxShape formato = BoxShape.circle;
  String textoFormato = 'quadrado';

  BoxShape mudarFormato(BoxShape formato) {
    return (formato == BoxShape.circle) ? BoxShape.rectangle : BoxShape.circle;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF162433),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        formato = mudarFormato(formato);
                        textoFormato = (textoFormato == 'quadrado') ? 'circulo' : 'quadrado';
                      });
                    },
                    child: Text("Mudar para $textoFormato"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cor = Color.fromARGB(
                          255,
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),
                        );
                      });
                    },
                    child: Text("Cor aleatoria"),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: cor, shape: formato),
            ),
          ],
        ),
      ),
    );
  }
}
