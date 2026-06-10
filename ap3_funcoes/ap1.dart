import 'dart:math';

void main() {
  final random = Random();
  const int tamanhoLista = 5;

  final lista1 = List.generate(tamanhoLista, (_) => random.nextInt(100));
  final lista2 = List.generate(tamanhoLista, (_) => random.nextInt(100));

  imprimirLista(lista1);
  imprimirLista(lista2);

  final lista3 = somarListas(lista1, lista2);
  imprimirLista(lista3);
}

void imprimirLista(List<int> lista) {
  print('Lista: ${lista.join(', ')}');
}

List<int> somarListas(List<int> lista1, List<int> lista2) {
  if (lista1.length != lista2.length) {
    print('As listas devem ter o mesmo tamanho.');
    return [];
  }

  final resultado = <int>[];
  for (var i = 0; i < lista1.length; i++) {
    resultado.add(lista1[i] + lista2[i]);
  }
  return resultado;
}
