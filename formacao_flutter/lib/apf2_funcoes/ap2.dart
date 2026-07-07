import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF162433),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              quadro(Colors.grey, [
                caixa(Colors.red, 10, 8),
                caixa(Colors.green, 18, 16),
                caixa(Colors.blue, 26, 24),
              ]),
              SizedBox(width: 16),

              quadro(Colors.black, [
                caixa(Colors.cyan, 10, 8),
                caixa(Colors.purple, 18, 16),
                caixa(Colors.yellow, 26, 24),
              ]),
              SizedBox(width: 16),

              Container(
                width: 100,
                height: 100,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    caixa(Colors.red, 10, 8),
                    caixa(Colors.yellow, 18, 16),
                    caixa(Colors.blue, 26, 24),
                  ],
                ),
              ),
              SizedBox(width: 16),

              quadro(Colors.white, [
                caixa(Color(0xFF5E35B1), 8, 6),
                caixa(Colors.deepOrange, 16, 14),
                caixa(Colors.yellow, 24, 22),
                caixa(Colors.lime, 32, 30),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  static Widget quadro(Color fundo, List<Widget> filhos) {
    return Container(
      width: 100,
      height: 100,
      color: fundo,
      child: Stack(children: filhos),
    );
  }

  static Widget caixa(Color cor, double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: Container(width: 50, height: 50, color: cor),
    );
  }
}
