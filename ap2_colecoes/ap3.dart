import 'dart:math';

void main() {
  var random = Random();

  // Gerar lista com 50 números aleatórios (10-21)
  final lista = List.generate(50, (_) => random.nextInt(12) + 10);

  print("Lista original: ${lista.join(' ; ')}");

  // Criar lista sem duplicatas
  var listaAtualizada = [];
  for (var i = 0; i < lista.length; i++) {
    // Adicionar elemento apenas se ele não já existe na lista atualizada
    if (listaAtualizada.contains(lista[i]) == false) {
      listaAtualizada.add(lista[i]);
    }
  }

  print("Lista atualizada: ${listaAtualizada.join(' ; ')}");

}
