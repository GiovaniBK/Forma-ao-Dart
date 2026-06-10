import 'dart:math';

void main() {
  final random = Random();

  final listaRaios = List.generate(10, (_) => random.nextDouble() * 100);

  for (var raio in listaRaios) {
    print('Raio: ${raio.toStringAsFixed(2)}');
    print('Perimetro: ${calcularPerimetro(raio).toStringAsFixed(2)}');
    print('Área: ${calcularArea(raio).toStringAsFixed(2)}');
    print('___________\n');
  }
}

double calcularPerimetro(raio){
  return 2 * pi * raio;
}
double calcularArea(raio) {
  return pi * pow(raio, 2);
}
