import 'dart:math';

void main(){
  // Criar uma lista vazia
  var lista = [];

  // Adicionar 10 números aleatórios à lista
  for (var i = 0; i < 10; i++) {
    lista.add(Random().nextInt(100));
  }
  
  // Imprimir cada elemento da lista com seu índice
  for (var i = 0; i < lista.length; i++) {
    print("Posição: ${i}, valor: ${lista[i]}");
  }
}