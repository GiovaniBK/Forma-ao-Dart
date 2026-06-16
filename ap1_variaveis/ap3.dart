import 'dart:math';

void main(){

  // Gerar dois números aleatórios entre 1 e 100
  int numero1 = Random().nextInt(100) + 1;
  int numero2 = Random().nextInt(100) + 1;

  // Imprimir valores iniciais
  print("Valores iniciais:");
  print("Número 1: $numero1");
  print("Número 2: $numero2");

  // Inverter variáveis usando uma variável auxiliar
  // 1. Guardar valor de numero1 em uma variável temporária
  final int guardar = numero1;
  // 2. Copiar valor de numero2 para numero1
  numero1 = numero2;
  // 3. Copiar valor temporário para numero2
  numero2 = guardar;
  
  // Imprimir valores após a inversão
  print("\nValores após a inversão:");
  print("Número 1: $numero1");
  print("Número 2: $numero2");
}