import 'dart:math';

void main(){
  // Lista de raios para calcular
  final lista = [5, 8, 12, 7.3, 18, 2, 25];

  // Itera sobre cada raio e exibe a área e perímetro formatados com 2 casas decimais
  lista.forEach((value) =>
  print("Raio: $value, área: ${calculaArea(value).toStringAsFixed(2)}, perímetro: ${calculaPerimetro(value).toStringAsFixed(2)}"));
}

// Calcula a área de um círculo: π * raio²
double calculaArea(valor){
  return pi * (valor*valor);
}

// Calcula o perímetro  de um círculo: 2 * π * raio
double calculaPerimetro(valor){
  return (2 * pi) * valor;
}
