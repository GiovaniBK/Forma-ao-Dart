import 'dart:math';

void main() {
  final random = Random();
  const int tamanhoLista = 5;

  // Gerar duas listas com 5 números aleatórios cada
  final lista1 = List.generate(tamanhoLista, (_) => random.nextInt(100));
  final lista2 = List.generate(tamanhoLista, (_) => random.nextInt(100));

  // Imprimir listas originais
  imprimirLista(lista1);
  imprimirLista(lista2);

  // Somar listas e imprimir resultado
  final lista3 = somarListas(lista1, lista2);
  imprimirLista(lista3);
}

// Função para imprimir uma lista de inteiros formatada
void imprimirLista(List<int> lista) {
  print('Lista: ${lista.join(', ')}');
}

// Função para somar as duas listas, elemento a elemento
// Retorna lista vazia se tamanhos forem diferentes
List<int> somarListas(List<int> lista1, List<int> lista2) {
  // Validar se as listas têm o mesmo tamanho
  if (lista1.length != lista2.length) {
    print('As listas devem ter o mesmo tamanho.');
    return [];
  }

  // Criar lista resultado e somar elementos índice a índice
  final resultado = <int>[];
  for (var i = 0; i < lista1.length; i++) {
    resultado.add(lista1[i] + lista2[i]);
  }
  return resultado;
}
