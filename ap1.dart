import 'dart:math';

void main(){
  var lista = [];

  for (var i = 0; i < 10; i++) {
    lista.add(Random().nextInt(100));
  }
  
  for (var i = 0; i < lista.length; i++) {
    print("Posição: ${i}, valor: ${lista[i]}");
  }
}