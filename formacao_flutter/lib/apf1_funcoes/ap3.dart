import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

enum EstadoJogo { jogando, ganhou, perdeu }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: MyWidget())),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final random = Random();

  int botaoCorreto = 0;
  int tentativasErradas = 0;
  int vitorias = 0;
  int derrotas = 0;
  EstadoJogo estadoJogo = EstadoJogo.jogando;

  // Esse método e chamado somente uma vez, ao iniciar o state
  @override
  void initState() {
    super.initState();

    _reiniciarPartida();
  }

  // Tratar a tentativa do usuário
  void tentativa(int opcao) {
    if (estadoJogo != EstadoJogo.jogando) {
      return;
    }

    setState(() {
      // Verificar se a opção escolhida esta correta
      if (opcao == botaoCorreto) {
        estadoJogo = EstadoJogo.ganhou;
        vitorias++;
      } else {
        // Se estiver errada, incrementa o contador de clicks
        tentativasErradas++;
      }

      // Se a quantidade de clicks for maior ou igual a 2, o usuário perdeu
      if (tentativasErradas >= 2 && estadoJogo == EstadoJogo.jogando) {
        estadoJogo = EstadoJogo.perdeu;
        derrotas++;
      }
    });
  }

  void reiniciarJogo() {
    setState(() {
      _reiniciarPartida();
    });
  }

  void _reiniciarPartida() {
    // Escolher um número de 0 a 2 para identificar o botão correto
    botaoCorreto = random.nextInt(3);
    tentativasErradas = 0;
    estadoJogo = EstadoJogo.jogando;
  }

  @override
  Widget build(BuildContext context) {
    return switch (estadoJogo) {
      EstadoJogo.jogando => TelaJogando(
        vitorias: vitorias,
        derrotas: derrotas,
        onTentativa: tentativa,
      ),
      EstadoJogo.ganhou => TelaGanhou(
        vitorias: vitorias,
        derrotas: derrotas,
        onReiniciar: reiniciarJogo,
      ),
      EstadoJogo.perdeu => TelaPerdeu(
        vitorias: vitorias,
        derrotas: derrotas,
        onReiniciar: reiniciarJogo,
      ),
    };
  }
}

class TelaJogando extends StatelessWidget {
  final int vitorias;
  final int derrotas;
  final void Function(int opcao) onTentativa;

  const TelaJogando({
    super.key,
    required this.vitorias,
    required this.derrotas,
    required this.onTentativa,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Vitórias: $vitorias | Derrotas: $derrotas'),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: () => onTentativa(0), child: const Text('A')),
        ElevatedButton(onPressed: () => onTentativa(1), child: const Text('B')),
        ElevatedButton(onPressed: () => onTentativa(2), child: const Text('C')),
      ],
    );
  }
}

class TelaGanhou extends StatelessWidget {
  final int vitorias;
  final int derrotas;
  final VoidCallback onReiniciar;

  const TelaGanhou({
    super.key,
    required this.vitorias,
    required this.derrotas,
    required this.onReiniciar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Você ganhou'),
          const SizedBox(height: 12),
          Text('Vitórias: $vitorias | Derrotas: $derrotas'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onReiniciar,
            child: const Text('Reiniciar jogo'),
          ),
        ],
      ),
    );
  }
}

class TelaPerdeu extends StatelessWidget {
  final int vitorias;
  final int derrotas;
  final VoidCallback onReiniciar;

  const TelaPerdeu({
    super.key,
    required this.vitorias,
    required this.derrotas,
    required this.onReiniciar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Você perdeu'),
          const SizedBox(height: 12),
          Text('Vitórias: $vitorias | Derrotas: $derrotas'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onReiniciar,
            child: const Text('Reiniciar jogo'),
          ),
        ],
      ),
    );
  }
}
