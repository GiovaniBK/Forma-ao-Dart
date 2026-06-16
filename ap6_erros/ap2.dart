void main(){
  final numero = 5;
  numeroPar(numero);
}

void numeroPar(int numero){
  try {
    if (numero % 2 != 0) {
      throw Exception('Entrada inválida. Insira apenas números pares.');
    } else {
      print('Entrada correta, você inseriu um número par.');
    }
  } catch (e) {
    print(e);
  }
}