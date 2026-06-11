import 'dart:math';

void main(){
  var random = Random();

  final lista = List.generate(50, (_)=> random.nextInt(15));

  print("Lista original: ${lista.join(' ; ')}");

  var listaAtualizada = [];
  for(var i = 0; i < lista.length; i++){
    if(lista[i]%2==0){
      listaAtualizada.add(lista[i]);
    }
  }

  print("Lista atualizada: ${listaAtualizada.join(' ; ')}");

}