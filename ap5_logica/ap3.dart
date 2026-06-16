import 'dart:math';

void main(){
  final random = Random();
  // Gerar número aleatório entre 100 e 1000
  final numero = random.nextInt(901) + 100;
  print("A soma dos números pares entre 0 e ${numero} é: ${somaDosPares(numero)}");
}

// Calcular soma de todos os números pares de 0 até numero
int somaDosPares(int numero){
  int soma = 0;
  // Começar do número e descer até 0
  while (numero > 0) {
    // Se número for par, adicionar à soma
    if (numero % 2 == 0) {
      soma += numero;
    }
    numero--;
  }
  return soma;
}