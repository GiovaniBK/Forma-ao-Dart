import 'dart:math';

void main() {
  final random = Random();

  try {
    // Gerar base e altura aleatórias
    double base = random.nextDouble() * 99;
    double altura = random.nextDouble() * 99;

    // Criar retângulo (pode lançar exceção se dimensões forem inválidas)
    final retangulo = Retangulo(base, altura);
    print('Area do retângulo: ${retangulo.calcularArea().toStringAsFixed(2)}');
  } catch (e) {
    // Capturar exceção de validação
    print(e);
  }
}

abstract interface class Forma {
  double calcularArea();
}

// Classe que implementa Forma
class Retangulo implements Forma {
  final double base;
  final double altura;

  // Construtor com validação de parâmetros
  Retangulo(this.base, this.altura){
    // Validar se dimensões são positivas
    if (base <= 0 || altura <= 0) {
      throw Exception(
        'Dimensões inválidas, informe apenas valores positivos maiores que zero',
      );
    }
  }

  @override
  double calcularArea() {
    return base * altura;
  }
}
