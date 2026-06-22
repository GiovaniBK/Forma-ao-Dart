import 'dart:math';

void main() {
  final pessoa = Pessoa();

  while (pessoa.precisaDeRefeicao()) {
    final fornecedor = fornecedorAleatorio();
    pessoa.refeicao(fornecedor);
  }

  pessoa.informacoes();
}

Fornecedor fornecedorAleatorio() {
  final fornecedores = <Fornecedor>[
    FornecedorDeBebidas(),
    FornecedorDeSanduiches(),
    FornecedorDeBolos(),
    FornecedorDeSaladas(),
    FornecedorDePetiscos(),
    FornecedorDeUltraCaloric(),
  ];

  final random = Random();
  return fornecedores[random.nextInt(fornecedores.length)];
}

enum StatusCaloria { deficitExtremo, deficit, satisfeita, excesso }

StatusCaloria obterStatusCaloria(int calorias) {
  if (calorias <= 500) {
    return StatusCaloria.deficitExtremo;
  } else if (calorias <= 1800) {
    return StatusCaloria.deficit;
  } else if (calorias <= 2500) {
    return StatusCaloria.satisfeita;
  } else {
    return StatusCaloria.excesso;
  }
}

String obterDescricaoStatus(StatusCaloria status) {
  switch (status) {
    case StatusCaloria.deficitExtremo:
      return 'Deficit extremo de calorias';
    case StatusCaloria.deficit:
      return 'Deficit de calorias';
    case StatusCaloria.satisfeita:
      return 'Pessoa está satisfeita';
    case StatusCaloria.excesso:
      return 'Excesso de calorias';
  }
}

class Produto {
  Produto(this.nome, this.calorias);

  final String nome;

  final int calorias;
}

abstract class Fornecedor {
  Produto fornecer();
}

class FornecedorDeBebidas implements Fornecedor {
  final _random = Random();
  final _bebidasDisponiveis = <Produto>[
    Produto('Agua', 0),
    Produto('Refrigerante', 200),
    Produto('Suco de fruta', 100),
    Produto('Energetico', 135),
    Produto('Cafe', 60),
    Produto('Cha', 35),
  ];

  @override
  Produto fornecer() {
    return _bebidasDisponiveis[_random.nextInt(_bebidasDisponiveis.length)];
  }
}

class FornecedorDeSanduiches implements Fornecedor {
  final _random = Random();
  final _sanduichesDisponiveis = <Produto>[
    Produto('Sanduiche de Frango', 450),
    Produto('Sanduiche de Presunto', 380),
    Produto('Sanduiche Vegetariano', 320),
    Produto('Sanduiche de Thon', 420),
  ];

  @override
  Produto fornecer() {
    return _sanduichesDisponiveis[_random.nextInt(
      _sanduichesDisponiveis.length,
    )];
  }
}

class FornecedorDeBolos implements Fornecedor {
  final _random = Random();
  final _bolosDisponiveis = <Produto>[
    Produto('Bolo de Chocolate', 680),
    Produto('Bolo de Cenoura', 550),
    Produto('Bolo de Morango', 490),
    Produto('Bolo de Milho', 620),
  ];

  @override
  Produto fornecer() {
    return _bolosDisponiveis[_random.nextInt(_bolosDisponiveis.length)];
  }
}

class FornecedorDeSaladas implements Fornecedor {
  final _random = Random();
  final _saladDisponivel = <Produto>[
    Produto('Salada Verde', 80),
    Produto('Salada de Alface', 75),
    Produto('Salada Mista', 150),
    Produto('Salada de Macarrao', 280),
  ];

  @override
  Produto fornecer() {
    return _saladDisponivel[_random.nextInt(_saladDisponivel.length)];
  }
}

class FornecedorDePetiscos implements Fornecedor {
  final _random = Random();
  final _petiscosDisponiveis = <Produto>[
    Produto('Batata Frita', 320),
    Produto('Pipoca', 150),
    Produto('Amendoim', 280),
    Produto('Biscoito Salgado', 200),
  ];

  @override
  Produto fornecer() {
    return _petiscosDisponiveis[_random.nextInt(_petiscosDisponiveis.length)];
  }
}

class FornecedorDeUltraCaloric implements Fornecedor {
  final _random = Random();
  final _ultraCaloricoDisponiveis = <Produto>[
    Produto('Pizza', 850),
    Produto('Hamburger Duplo', 920),
    Produto('Sorvete Completo', 750),
    Produto('Pudim com Calda', 680),
  ];

  @override
  Produto fornecer() {
    return _ultraCaloricoDisponiveis[_random.nextInt(
      _ultraCaloricoDisponiveis.length,
    )];
  }
}

class Pessoa {
  late int _caloriasConsumidas;

  int _numeroRefeicoes = 0;

  Pessoa() {
    final random = Random();
    _caloriasConsumidas = random.nextInt(2500) + 500;
    print('Nível inicial de calorias: $_caloriasConsumidas\n');
  }

  bool precisaDeRefeicao() {
    final status = obterStatusCaloria(_caloriasConsumidas);
    return status != StatusCaloria.satisfeita &&
        status != StatusCaloria.excesso;
  }

  void informacoes() {
    final status = obterStatusCaloria(_caloriasConsumidas);
    final descricao = obterDescricaoStatus(status);

    print('\n--- Informações da Pessoa ---');
    print('Calorias consumidas: $_caloriasConsumidas');
    print('Status: $descricao');
    print('Número de refeições: $_numeroRefeicoes');
  }

  void refeicao(Fornecedor fornecedor) {
    final produto = fornecedor.fornecer();
    print('Consumindo ${produto.nome} (${produto.calorias} calorias)');

    _caloriasConsumidas += produto.calorias;
    _numeroRefeicoes++;
  }
}
