import 'dart:math';

void main(){

  int numero1 = Random().nextInt(100) + 1;
  int numero2 = Random().nextInt(100) + 1;

  // Imprimir valores iniciais
  print("Valores iniciais:");
  print("Número 1: $numero1");
  print("Número 2: $numero2");

  // Inverter variáveis
  final int guardar = numero1;
  numero1 = numero2;
  numero2 = guardar;
  
  // Imprimir valores invertidos
  print("\nValores após a inversão:");
  print("Número 1: $numero1");
  print("Número 2: $numero2");
}