import 'dart:collection';
import 'dart:io';

void main() {
  Baralho baralho = Baralho();
  baralho.empilhar("A", "paus");
  baralho.empilhar("A", "copas");
  baralho.empilhar("A", "espadas");
  baralho.empilhar("A", "ouros");

  int opcao = 0;
  do {
    print("1 - Empilhar uma carta");
    print("2 - Remover uma carta");
    print("3 - Remover todas as cartas");
    print("4 - Imprimir a ultima carta");
    print("5 - Sair");
    stdout.write("Digite a opção que você quer: ");
    opcao = int.parse(stdin.readLineSync()!);
    print("");

    switch (opcao) {
      case 1:
        final valorENaipe = baralho.cartaENaipe();
        baralho.empilhar(valorENaipe['valor']!, valorENaipe['naipe']!);
        break;
      case 2:
        baralho.remover();
        break;
      case 3:
        while (baralho.pilhaDeBaralho.isNotEmpty) {
          baralho.remover();
        }
        print("Todas as cartas foram removidas.\n");
        break;
      case 4:
        final ultimaCarta = baralho.obterUltimaCarta();
        if (ultimaCarta != null) {
          print("$ultimaCarta\n");
        } else {
          print("O baralho está vazio!\n");
        }
        break;
      case 5:
        print("Saindo...");
        break;
      default:
        print("Opção inválida, tente novamente\n");
    }
  } while (opcao != 5);
}

class Carta {
  final String valor;
  final String naipe;

  Carta(this.valor, this.naipe);

  @override
  String toString() => "$valor de $naipe";
}

class Baralho {
  Queue<Carta> pilhaDeBaralho = Queue<Carta>();
  final naipes = {"paus", "copas", "espadas", "ouros"};
  final cartas = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};

  void empilhar(String carta, String naipe) {
    if (naipes.contains(naipe) && cartas.contains(carta)) {
      pilhaDeBaralho.add(Carta(carta, naipe));
    }
  }

  void remover() {
    if (pilhaDeBaralho.isNotEmpty) {
      final removida = pilhaDeBaralho.removeLast();
      // Remove a última carta empilhada (comportamento de pilha)
      print("Carta removida: $removida\n");
    } else {
      print("O baralho está vazio!\n");
    }
  }

  Carta? obterUltimaCarta() {
    if (pilhaDeBaralho.isNotEmpty) {
      return pilhaDeBaralho.last;
    }
    return null;
  }

  Map<String, String> cartaENaipe() {
    while (true) {
      stdout.write("Digite o valor da carta que você quer adicionar ao baralho (1,2,3...Q,K,A): ");
      String carta = (stdin.readLineSync()!).toUpperCase();
      if (!cartas.contains(carta)) {
        print("Carta inválida!");
        continue;
      }
      stdout.write("Digite o naipe que você quer adicionar ao baralho (paus, espadas, ouros e copas): ");
      String naipe = (stdin.readLineSync()!).toLowerCase();
      print("");
      if (!naipes.contains(naipe)) {
        print("Naipe inválido!");
        continue;
      }
      return {'valor': carta, 'naipe': naipe};
    }
  }
}
