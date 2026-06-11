void main(){
  final mapa = {"Nelson": null, "Jane": null, "Jack": 16,
   "Rupert": 37, "Andy": 13, "Kim": 27, "Robert": 31};

   for (var nome in mapa.keys){
    mapa[nome] != null ? print("$nome: ${mapa[nome]} anos") : print("$nome: idade não informada");
   }
}

