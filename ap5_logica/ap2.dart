import 'dart:math';

void main(){
  final random = Random();
  for (int i = 0; i <= 5; i++) {
    int numero = random.nextInt(26);
    print("Número: ${numero+1} -> Letra: ${letraCorrespondente(numero).toUpperCase()}");
  }
}

String letraCorrespondente(int numero){ 
  List<String> alfabeto = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
    'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
    's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  ];
  return alfabeto[numero];
}