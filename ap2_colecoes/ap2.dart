import 'dart:math';

void main(){
  var random = Random();

  // Gerar lista com 50 números aleatórios (0-15)
  final lista = List.generate(50, (_)=> random.nextInt(16));

  // Imprimir lista original com elementos separados por ' ; '
  print("Lista original: ${lista.join(' ; ')}");

  // Criar nova lista contendo apenas números pares
  var listaAtualizada = [];
  for(var i = 0; i < lista.length; i++){
    // Verificar se o número é par (resto da divisão por 2 = 0)
    if(lista[i]%2==0){
      listaAtualizada.add(lista[i]);
    }
  }

  print("Lista atualizada: ${listaAtualizada.join(' ; ')}");

}