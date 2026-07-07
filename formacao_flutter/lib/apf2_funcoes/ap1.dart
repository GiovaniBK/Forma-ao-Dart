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
        backgroundColor: Color(0xFF152232),
        body: Center(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    caixa(Colors.red),
                    SizedBox(width: 8),
                    caixa(Colors.green),
                    SizedBox(width: 8),
                    caixa(Colors.blue),
                  ],
                ),

                SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.yellow,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      retangulo(Colors.purple),

                      SizedBox(width: 8),

                      retangulo(Colors.cyan),

                      SizedBox(width: 8),

                      Column(
                        children: [
                          caixa(Colors.purple),
                          SizedBox(height: 8),
                          caixa(Colors.cyan),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8),

                Container(
                  width: 100,
                  height: 68,
                  color: Colors.grey,
                  child: Center(child: caixa(Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget caixa(Color cor) {
    return Container(width: 50, height: 50, color: cor);
  }

  static Widget retangulo(Color cor) {
    return Container(width: 50, height: 100, color: cor);
  }
}
