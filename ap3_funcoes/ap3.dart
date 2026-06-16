import 'dart:math';

void main() {
  final random = Random();

  // Gerar 10 raios aleatórios entre 0 e 100
  final listaRaios = List.generate(10, (_) => random.nextDouble() * 100);

  // Para cada raio, calcular e imprimir perímetro e área
  for (var raio in listaRaios) {
    print('Raio: ${raio.toStringAsFixed(2)}');
    print('Perimetro: ${calcularPerimetro(raio).toStringAsFixed(2)}');
    print('Área: ${calcularArea(raio).toStringAsFixed(2)}');
    print('___________\n');
  }
}

// Calcular perímetro de um círculo: P = 2 * π * r
double calcularPerimetro(raio){
  return 2 * pi * raio;
}

// Calcular área de um círculo: A = π * r²
double calcularArea(raio) {
  return pi * pow(raio, 2);
}
