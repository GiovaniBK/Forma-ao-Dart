void main(){
  // Mapa com nome (chave) e idade (valor)
  final mapa = {"Nelson": null, "Jane": null, "Jack": 16,
   "Rupert": 37, "Andy": 13, "Kim": 27, "Robert": 31};

   // Imprimir dados verificando se idade é null
   for (var nome in mapa.keys){
    // Se idade não é null, imprimir idade; senão imprimir "não informada"
    mapa[nome] != null ? print("$nome: ${mapa[nome]} anos") : print("$nome: idade não informada");
   }
}

