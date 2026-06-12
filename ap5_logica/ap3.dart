import 'dart:math';

void main(){
  final random = Random();
  final numero = random.nextInt(900) + 100;
  print("A soma dos números pares entre 0 e ${numero} é: ${somaDosPares(numero)}");
}

int somaDosPares(int numero){
  int soma = 0;
  while (numero > 0) {
    if (numero % 2 == 0) {
      soma += numero;
    }
    numero--;
  }
  return soma;
}