import 'dart:math';

void main() {
  final random = Random();

  try {
    double base = random.nextDouble() * 99;
    double altura = random.nextDouble() * 99;

    final retangulo = Retangulo(base, altura);
    print('Area do retângulo: ${retangulo.calcularArea().toStringAsFixed(2)}');
  } catch (e) {
    print(e);
  }
}

abstract interface class Forma {
  double calcularArea();
}

class Retangulo implements Forma {
  final double base;
  final double altura;

  Retangulo(this.base, this.altura){
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
