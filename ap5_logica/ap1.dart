void main(){
  final lista = geradorDeLista(10);
  
  lista.forEach((numero) {
    print("Impar: $numero");
  });
}

List<int> geradorDeLista(int n){
  List<int> lista = [];
  for(int i = 0; i <= n; i++){
    lista.add(i);
  }

  for (var i = 0; i < lista.length; i++) {
    if (lista[i] % 2 == 0) {
      lista.removeAt(i);
    }
  }
  return lista;
}
