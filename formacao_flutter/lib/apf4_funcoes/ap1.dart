import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class CorItem {
  final String nome;
  final Color cor;

  const CorItem(this.nome, this.cor);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const List<CorItem> cores = [
    CorItem('Vermelho', Colors.red),
    CorItem('Azul', Colors.blue),
    CorItem('Verde', Colors.green),
    CorItem('Amarelo', Colors.yellow),
    CorItem('Roxo', Colors.purple),
    CorItem('Laranja', Colors.orange),
    CorItem('Rosa', Colors.pink),
    CorItem('Ciano', Colors.cyan),
    CorItem('Marrom', Colors.brown),
    CorItem('Cinza', Colors.grey),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: cores.length,
          itemBuilder: (context, index) {
            final corItem = cores[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaCorSelecionada(corItem: corItem),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 70,
                color: corItem.cor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  corItem.nome,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TelaCorSelecionada extends StatelessWidget {
  final CorItem corItem;

  const TelaCorSelecionada({super.key, required this.corItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(corItem.nome)),
      backgroundColor: corItem.cor,
      body: Center(
        child: Text(
          corItem.nome,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
