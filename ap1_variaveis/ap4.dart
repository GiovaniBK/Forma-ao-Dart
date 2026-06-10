import 'dart:math';

void main(){
  // Inicializando as variáveis
  final int numero1 = Random().nextInt(100) + 1;
  final int numero2 = Random().nextInt(100) + 1;

  final double resultado = numero1/numero2;

  final int parteInteira = resultado.toInt();
  final double parteDecimal = resultado - parteInteira;

  // Imprimir valores iniciais
  print("Número 1: $numero1");
  print("Número 2: $numero2");
  print("Resultado da divisão: $resultado");
  print("Parte inteiro do resultado: $parteInteira");
  print("Parte decimal do resultado: $parteDecimal");
}