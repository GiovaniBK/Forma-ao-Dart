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
  Color cor = Colors.grey;
  final random = Random();
  late final botaoCorreto = random.nextInt(3);
  int tentativas = 0;
  bool finalizado = false;
  String mensagem = 'Escolha um botão';

  void verificarEscolha(int valor) {
    if (finalizado) {
      return;
    }

    setState(() {
      tentativas++;

      if (valor == botaoCorreto) {
        cor = Colors.green;
        mensagem = 'Você acertou!';
        finalizado = true;
      } else if (tentativas >= 2) {
        cor = Colors.red;
        mensagem = 'Você perdeu';
        finalizado = true;
      } else {
        mensagem = 'Tente novamente';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: cor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mensagem,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: finalizado ? null : () => verificarEscolha(0),
                    child: const Text("A"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: finalizado ? null : () => verificarEscolha(1),
                    child: const Text("B"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: finalizado ? null : () => verificarEscolha(2),
                    child: const Text("C"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
