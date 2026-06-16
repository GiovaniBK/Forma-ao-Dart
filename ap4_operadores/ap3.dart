void main(){
  final List<String> lista = ['Joao', 'Maria', 'Pedro', 'Ana', 'Carlos', 'Mariana', 'Lucas', 'Rafael'];

  // Remover 'Carlos' da lista usando parâmetros nomeados
  List<String> listaAtualizada = removeDaLista(lista: lista, item:'Carlos');
  print("Lista atualizada: $listaAtualizada");
}
// Remover item de uma lista
List<String> removeDaLista({List<String>? lista, String? item}){
  // Usar ?. para chamar remove apenas se lista não for null
  lista?.remove(item);

  // Retornar lista ou lista vazia se lista for null
  return lista ?? [];
}