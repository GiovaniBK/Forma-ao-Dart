void main(){
  // Testar com número ímpar
  final numero = 5;
  numeroPar(numero);
}

// Verificar se número é par, lançar exceção se for ímpar
void numeroPar(int numero){
  try {
    // Verificar se número é ímpar
    if (numero % 2 != 0) {
      // Lançar exceção com mensagem
      throw Exception('Entrada inválida. Insira apenas números pares.');
    } else {
      print('Entrada correta, você inseriu um número par.');
    }
  } catch (e) {
    // Capturar e exibir exceção
    print(e);
  }
}