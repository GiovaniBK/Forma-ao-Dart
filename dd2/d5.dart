import 'dart:io';
import 'dart:math';

void main() {
  final mercado = ListaMercado();
  mercado.itens.add(Item('Arroz', 2));
  mercado.itens.add(Item('Feijao', 1));
  mercado.itens.add(Item('Leite', 3));
  mercado.itens.add(Item('Pao', 2));
  mercado.itens.add(Item('Manteiga', 1));

  mercado.marcarComprado('Arroz');
  mercado.marcarComprado('Leite');
  mercado.marcarSemEstoque('Manteiga');

  int opcao = 0;
  do {
    print('Menu: ');
    print('1 - Incluir novos itens desejados');
    print('2 - Separar itens comprados dos desejados');
    print('3 - Separar itens sem estoque dos desejados');
    print('4 - Exibir itens desejados com quantidades');
    print('5 - Escolher um item pendente aleatoriamente');
    print('6 - Mostrar indicador de progresso');
    print('7 - Comprar item da lista de desejados');
    print('8 - Sair');
    stdout.write('Escolha uma opcao: ');
    opcao = int.parse(stdin.readLineSync()!.trim());

    switch (opcao) {
      case 1:
        mercado.incluirItem();
        break;
      case 2:
        mercado.exibirCompradosVsDesejados();
        break;
      case 3:
        mercado.exibirSemEstoqueVsDesejados();
        break;
      case 4:
        mercado.exibirDesejados();
        break;
      case 5:
        mercado.escolherAleatorio();
        break;
      case 6:
        mercado.exibirProgresso();
        break;
      case 7:
        mercado.comprarItem();
        break;
      case 8:
        print('Encerrando... Ate a proxima!');
        break;
      default:
        print('Opcao invalida. Tente novamente.');
    }
  } while (opcao != 8);
}

class Item {
  String nome;
  int quantidade;
  bool comprado;
  bool semEstoque;

  Item(this.nome, this.quantidade) : comprado = false, semEstoque = false;
}

class ListaMercado {
  List<Item> itens = [];

  
  void incluirItem() {
    // Lê dados do usuário para adicionar um novo item à lista
    stdout.write("Digite o nome do item: ");
    String nome = stdin.readLineSync()!.trim();

    stdout.write("Digite a quantidade: ");
    int quantidade = int.parse(stdin.readLineSync()!.trim());

    itens.add(Item(nome, quantidade));
    print('"$nome" adicionado a lista.');
  }

  
  void exibirCompradosVsDesejados() {
    print('\nItens Comprados:');
    bool temComprado = false;
    for (int i = 0; i < itens.length; i++) {
      if (itens[i].comprado) {
        print('  ${itens[i].nome} (${itens[i].quantidade})');
        temComprado = true;
      }
    }
    if (!temComprado) print('Nenhum item comprado ainda.');

    print('\nItens Desejados (pendentes): ');
    bool temDesejado = false;
    for (int i = 0; i < itens.length; i++) {
      if (!itens[i].comprado && !itens[i].semEstoque) {
        print('  ${itens[i].nome} (${itens[i].quantidade})');
        temDesejado = true;
      }
    }
    if (!temDesejado) print('Nenhum item pendente.');
  }

  
  void exibirSemEstoqueVsDesejados() {
    print('\nItens Sem Estoque:');
    bool temSemEstoque = false;
    for (int i = 0; i < itens.length; i++) {
      if (itens[i].semEstoque) {
        print('  ${itens[i].nome} (${itens[i].quantidade})');
        temSemEstoque = true;
      }
    }
    if (!temSemEstoque) print('Nenhum item sem estoque.');

    print('\nItens Desejados (pendentes): ');
    bool temDesejado = false;
    for (int i = 0; i < itens.length; i++) {
      if (!itens[i].comprado && !itens[i].semEstoque) {
        print('  ${itens[i].nome} (${itens[i].quantidade})');
        temDesejado = true;
      }
    }
    if (!temDesejado) print('Nenhum item pendente.');
  }

  
  void exibirDesejados() {
    print('\nItens Desejados: ');
    bool temDesejado = false;
    for (int i = 0; i < itens.length; i++) {
      if (!itens[i].comprado && !itens[i].semEstoque) {
        print('  ${itens[i].nome} - Quantidade: ${itens[i].quantidade}');
        temDesejado = true;
      }
    }
    if (!temDesejado) print('Nenhum item desejado na lista.');
  }

  
  void escolherAleatorio() {
    List<Item> pendentes = [];
    for (int i = 0; i < itens.length; i++) {
      if (!itens[i].comprado && !itens[i].semEstoque) {
        pendentes.add(itens[i]);
      }
    }

    if (pendentes.length == 0) {
      print('Nenhum item pendente para sortear.');
      return;
    }

    // Sorteia um item pendente aleatoriamente
    Item sorteado = pendentes[Random().nextInt(pendentes.length)];
    print('\nItem sorteado: ${sorteado.nome} (${sorteado.quantidade})');
  }

  
  void exibirProgresso() {
    int totalDesejados = 0;
    int totalComprados = 0;
    for (int i = 0; i < itens.length; i++) {
      if (!itens[i].semEstoque) totalDesejados++;
      if (itens[i].comprado) totalComprados++;
    }
    // Exibe progresso no formato: comprados / desejados
    print('\nProgresso: $totalComprados/$totalDesejados');
  }

  
  void comprarItem() {
    print('\nItens Desejados: ');
    bool temDesejado = false;
    for (int i = 0; i < itens.length; i++) {
      if (!itens[i].comprado && !itens[i].semEstoque) {
        print('  ${i + 1}. ${itens[i].nome} (${itens[i].quantidade})');
        temDesejado = true;
      }
    }

    if (!temDesejado) {
      print('Nenhum item pendente para comprar.');
      return;
    }

    stdout.write('Digite o nome do item que foi comprado: ');
    String nome = stdin.readLineSync()!.trim();

    bool encontrado = false;
    for (int i = 0; i < itens.length; i++) {
      if (itens[i].nome.toLowerCase() == nome.toLowerCase() &&
          !itens[i].comprado &&
          !itens[i].semEstoque) {
        itens[i].comprado = true;
        print('"${itens[i].nome}" marcado como comprado.');
        encontrado = true;
        break;
      }
    }

    if (!encontrado) print('Item "$nome" nao encontrado nos desejados.');
  }

  
  void marcarComprado(String nome) {
    for (int i = 0; i < itens.length; i++) {
      if (itens[i].nome.toLowerCase() == nome.toLowerCase()) {
        itens[i].comprado = true;
        return;
      }
    }
    throw Exception('Item "$nome" nao encontrado.');
  }

  
  void marcarSemEstoque(String nome) {
    for (int i = 0; i < itens.length; i++) {
      if (itens[i].nome.toLowerCase() == nome.toLowerCase()) {
        itens[i].semEstoque = true;
        return;
      }
    }
    throw Exception('Item "$nome" nao encontrado.');
  }
}
