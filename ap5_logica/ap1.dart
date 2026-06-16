void main(){
  // Gerar lista de números
  final lista = geradorDeLista(10);
  
  // Imprimir cada número ímpar
  lista.forEach((numero) {
    print("Impar: $numero");
  });
}

// Gerar lista com números de 0 a n, removendo os pares
List<int> geradorDeLista(int n){
  List<int> lista = [];
  // Preencher lista com números de 0 a n
  for(int i = 0; i <= n; i++){
    lista.add(i);
  }

  // Remover números pares
  for (var i = 0; i < lista.length; i++) {
    if (lista[i] % 2 == 0) {
      lista.removeAt(i);
    }
  }
  return lista;
}
