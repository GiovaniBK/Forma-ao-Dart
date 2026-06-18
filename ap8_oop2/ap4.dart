import 'dart:math';

void main(){
  // Gera um número aleatório entre 0 e 1000
  final random = Random();
  final numero = random.nextInt(1000);
  
  // Chama o método estático dobro sem precisar instanciar Calculadora
  final dobro = Calculadora.dobro(numero);

  print("O dobro do número $numero é: $dobro");
}

// Classe abstrata que contém métodos estáticos de cálculo
abstract class Calculadora{
  // Método estático que calcula o dobro de um número
  static int dobro(int numero){
    return numero * 2;
  }
}
