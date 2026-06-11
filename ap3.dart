import 'dart:math';

void main() {
  var random = Random();

  final lista = List.generate(50, (_) => random.nextInt(11) + 10);

  print("Lista original: ${lista.join(' ; ')}");

  var listaAtualizada = [];
  for (var i = 0; i < lista.length; i++) {
    if (listaAtualizada.contains(lista[i]) == false) {
      listaAtualizada.add(lista[i]);
    }
  }

  print("Lista atualizada: ${listaAtualizada.join(' ; ')}");

}
