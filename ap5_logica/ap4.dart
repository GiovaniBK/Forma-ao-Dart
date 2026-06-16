void main() {
  final listaNomes = [
    "Joao",
    "Maria",
    "Pedro",
    "Maria",
    "Ana",
    "Joao",
    "Maria",
    "Fernanda",
    "Carlos",
    "Maria"
  ];

  // Procurar quantas vezes 'Ana' aparece na lista
  final nome = 'Ana';
  final quantidade = contarNome(listaNomes, nome);

  // Imprimir resultado
  if (quantidade == 1) {
    print('O nome $nome foi encontrado 1 vez');
  } else if (quantidade > 0) {
    print('O nome $nome foi encontrado $quantidade vezes');
  } else {
    print('O nome nao foi encontrado');
  }
}

// Contar quantas vezes um nome aparece em uma lista
int contarNome(List<String> lista, String nome) {
  int contador = 0;
  for (var item in lista) {
    // Incrementar contador se item é igual ao nome procurado
    if (item == nome) {
      contador++;
    }
  }
  return contador;
}

