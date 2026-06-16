import 'dart:math';

void main(){
  // Gerar dois números aleatórios
  final int numero1 = Random().nextInt(100) + 1;
  final int numero2 = Random().nextInt(100) + 1;

  // Realizar divisão entre os números
  final double resultado = numero1/numero2;

  // Extrair a parte inteira convertendo para int
  final int parteInteira = resultado.toInt();
  // Calcular a parte decimal (resultado - parte inteira)
  final double parteDecimal = resultado - parteInteira;

  // Imprimir resultados
  print("Número 1: $numero1");
  print("Número 2: $numero2");
  print("Resultado da divisão: $resultado");
  print("Parte inteiro do resultado: $parteInteira");
  print("Parte decimal do resultado: $parteDecimal");
}