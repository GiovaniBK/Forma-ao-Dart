import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apf6_funcoes/state/estado_lista_de_pessoas.dart';
import 'package:apf6_funcoes/telas/tela_formulario.dart';
import 'package:apf6_funcoes/telas/tela_inicial.dart';
import 'package:apf6_funcoes/telas/tela_listagem.dart';
import 'package:apf6_funcoes/models/pessoa.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EstadoListaDePessoas(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: darkBlue,
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.tealAccent,
            secondary: Colors.tealAccent,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 11, 22, 33),
            foregroundColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const TelaInicial(),
          '/listagem': (_) => const TelaListagem(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/formulario') {
            final pessoa = settings.arguments as Pessoa?;
            return MaterialPageRoute(
              builder: (_) => TelaFormulario(pessoa: pessoa),
            );
          }

          return null;
        },
      ),
    );
  }
}

