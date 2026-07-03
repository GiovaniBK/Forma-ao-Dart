import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color cor = Colors.black;
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ap1 da apf1_funcoes do curso de flutter do Lince Tech Academy",
                style: TextStyle(color: cor, fontSize: 24),
              ),
              const SizedBox(height: 20),
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
                child: const Text("Sortear cor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
