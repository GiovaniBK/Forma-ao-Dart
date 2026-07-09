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
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  bool _inativo = false;

  String? _erroNome;
  String? _erroIdade;

  String? _nomeSalvo;
  int? _idadeSalva;
  bool? _inativoSalvo;

  bool _validarNome(String nome) {
    if (nome.isEmpty) {
      _erroNome = 'Nome não pode ser vazio';
      return false;
    }
    if (nome.length < 3) {
      _erroNome = 'Nome não pode ter menos de 3 letras';
      return false;
    }
    final primeiraLetra = nome[0];
    if (primeiraLetra != primeiraLetra.toUpperCase() ||
        primeiraLetra == primeiraLetra.toLowerCase()) {
      _erroNome = 'Nome precisa começar com uma letra maiúscula';
      return false;
    }
    _erroNome = null;
    return true;
  }

  bool _validarIdade(String idadeTexto) {
    final idade = int.tryParse(idadeTexto);
    if (idade == null) {
      _erroIdade = "Idade precisa ser um número válido";
      return false;
    }
    if (idade < 18) {
      _erroIdade = 'Idade precisa ser maior ou igual a 18';
      return false;
    }
    _erroIdade = null;
    return true;
  }

  void _salvar() {
    final nome = _nomeController.text;
    final idadeTexto = _idadeController.text;

    final nomeValido = _validarNome(nome);
    final idadeValida = _validarIdade(idadeTexto);

    setState(() {
      if (nomeValido && idadeValida) {
        _nomeSalvo = nome;
        _idadeSalva = int.parse(idadeTexto);
        _inativoSalvo = _inativo;
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Formulário Básico')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_erroNome != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      _erroNome!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 16),

                TextField(
                  controller: _idadeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Idade',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_erroIdade != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      _erroIdade!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 16),

                CheckboxListTile(
                  title: const Text('Inativo'),
                  value: _inativo,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? novoValor) {
                    setState(() {
                      _inativo = novoValor ?? false;
                    });
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),

                const SizedBox(height: 24),

                if (_nomeSalvo != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: _inativoSalvo! ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome: $_nomeSalvo',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Idade: $_idadeSalva',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _inativoSalvo! ? 'Status: Inativo' : 'Status: Ativo',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
