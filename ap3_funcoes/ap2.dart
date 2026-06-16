import 'dart:math';

void main(){
  // Chamar funcaoA passando diferentes funções como parâmetro
  final resultado1 = funcaoA(funcaoB);
  final resultado2 = funcaoA(funcaoC);

  print('A(B) = $resultado1');
  print('A(C) = $resultado2');

}

// FuncaoA que recebe uma função como parâmetro
// Aplica a função a dois números aleatórios e soma os resultados
num funcaoA(num Function(num) funcao){
  final random = Random();

  // Aplicar função aos números aleatórios
  final numero1 = funcao(random.nextInt(100));
  final numero2 = funcao(random.nextInt(100));

  return numero1+numero2;
}

// Função que calcula (numero * 5) / 2
double funcaoB(num numero){
  return (numero * 5)/2;
}

// Função que calcula numero * 30
double funcaoC(num numero){
  return (numero*30);
}
