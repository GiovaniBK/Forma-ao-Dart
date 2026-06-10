import 'dart:math';

void main(){
  final resultado1 = funcaoA(funcaoB);
  final resultado2 = funcaoA(funcaoC);

  print('A(B) = $resultado1');
  print('A(C) = $resultado2');

}

num funcaoA(num Function(num) funcao){
  final random = Random();

  final numero1 = funcao(random.nextInt(100));
  final numero2 = funcao(random.nextInt(100));

  return numero1+numero2;
}

double funcaoB(num numero){
  return (numero * 5)/2;
}

double funcaoC(num numero){
  return (numero*30);
}
