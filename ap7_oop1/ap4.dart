import 'dart:math';

void main() {
  final random = Random();

  // Criar instância de Pessoa
  final pessoa = Pessoa();
  // Usar setters para atribuir valores
  pessoa.nome = "Maria";
  pessoa.idade = random.nextInt(99) + 1;
  pessoa.altura = 1 + (random.nextDouble() * 1.3);

  // Usar getters para acessar valores
  print("Nome: ${pessoa.nome}");
  print("Idade: ${pessoa.idade}");
  print("Altura: ${pessoa.altura.toStringAsFixed(2)}");
}

// Classe Pessoa
class Pessoa {
  // Propriedades privadas 
  String _nome = '';
  int _idade = 0;
  double _altura = 0.0;

  // Getter para idade
  int get idade => _idade;
  // Setter para idade com validação
  set idade(int valor) {
    if (valor >= 0) {
      _idade = valor;
    } else {
      print('A idade deve ser um valor maior ou igual a zero.');
    }
  }

  // Getter para nome
  String get nome => _nome;
  // Setter para nome
  set nome(String valor) {
    _nome = valor;
  }

  // Getter para altura
  double get altura => _altura;
  // Setter para altura
  set altura(double valor) {
    _altura = valor;
  }
}
