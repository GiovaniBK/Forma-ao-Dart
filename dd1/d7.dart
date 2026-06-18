void main(){
  // Lista de números para somar
  final lista = [10, 35, 999, 126, 95, 7, 348, 462, 43, 109];

  // Exibe o resultado da soma da lista usando 4 formas diferentes
  print('for: ${funcaoFor(lista)}');
  print('while: ${funcaoWhile(lista)}');
  print('recursão: ${funcaoRecursiva(lista, 0)}');
  print('lista: ${funcaoLista(lista)}');
}

// Calcula a soma usando um loop for-in
int funcaoFor(List<int> lista){
  int soma = 0;
  for (var numero in lista) {
    soma += numero;
  }
  return soma;
}

// Calcula a soma usando um loop while com índice
int funcaoWhile(List<int> lista){
  int soma = 0;
  int contador = 0;
  while (contador < lista.length){
    soma += lista[contador];
    contador ++;
  }
  return soma;
}

// Calcula a soma usando RECURSÃO
// Função que chama a si mesma até o final da lista
int funcaoRecursiva(List<int> lista, int index){
  if (index >= lista.length) {
    return 0; //retorna 0 quando alcança o fim
  }
  // Retorna o valor atual + a soma do restante da lista (chamada recursiva)
  return lista[index] + funcaoRecursiva(lista, index + 1);
}

// Calcula a soma usando o método reduce
// reduce: combina todos os elementos da lista em um único valor
int funcaoLista(List<int> lista){
  return lista.reduce((a, b) => a + b);
}
