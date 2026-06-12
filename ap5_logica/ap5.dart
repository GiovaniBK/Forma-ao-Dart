import 'dart:math';

void main() {
  final random = Random();
  final opcao = random.nextInt(6);

  switch (opcao) {
    case 0:
      print('Opção inválida');
      break;
    case 1:
    case 2:
    case 3:
    case 4:
      print('Encontrado $opcao');
      break;
    case 5:
      print('Encontrado final');
      break;
    default:
      print('Opção inválida');
  }
}