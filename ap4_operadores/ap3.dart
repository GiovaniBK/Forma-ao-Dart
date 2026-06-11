void main(){
  final List<String> lista = ['Joao', 'Maria', 'Pedro', 'Ana', 'Carlos', 'Mariana', 'Lucas', 'Rafael'];

  List<String> listaAtualizada = removeDaLista(lista: lista, item:'Carlos');
  print("Lista atualizada: $listaAtualizada");
}

List<String> removeDaLista({List<String>? lista, String? item}){
  lista?.remove(item);

  return lista ?? [];
}