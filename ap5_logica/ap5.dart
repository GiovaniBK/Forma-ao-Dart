import 'dart:math';

void main() {
  final random = Random();
  // Gerar número aleatório entre 0 e 5
  final opcao = random.nextInt(6);

  // Usar switch para diferentes opções
  switch (opcao) {
    case 0:
      print('Opção inválida');
      break;
    case 1:
    case 2:
    case 3:
    case 4:
      // Os casos 1, 2, 3, 4 executam este bloco
      print('Encontrado $opcao');
      break;
    case 5:
      print('Encontrado final');
      break;
    default:
      // Executado se nenhum caso corresponder
      print('Opção inválida');
  }
}