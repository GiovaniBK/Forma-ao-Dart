void main() {
  final controleDePessoas = ControleDePessoas();

  controleDePessoas
    ..cadastrarPessoa(Pessoa('Jose', Mes.abril))
    ..cadastrarPessoa(Pessoa('Arthur', Mes.agosto))
    ..cadastrarPessoa(Pessoa('Joao', Mes.abril))
    ..cadastrarPessoa(Pessoa('Jesse', Mes.dezembro))
    ..cadastrarPessoa(Pessoa('Roberta', Mes.fevereiro))
    ..cadastrarPessoa(Pessoa('Carla', Mes.fevereiro))
    ..cadastrarPessoa(Pessoa('Thania', Mes.agosto))
    ..cadastrarPessoa(Pessoa('Rafaela', Mes.marco))
    ..cadastrarPessoa(Pessoa('Yuri', Mes.junho))
    ..cadastrarPessoa(Pessoa('Jonas', Mes.setembro))
    ..cadastrarPessoa(Pessoa('Elias', Mes.outubro))
    ..cadastrarPessoa(Pessoa('Abel', Mes.maio))
    ..cadastrarPessoa(Pessoa('Danilo', Mes.abril))
    ..cadastrarPessoa(Pessoa('Jonathan', Mes.abril))
    ..cadastrarPessoa(Pessoa('Joseph', Mes.setembro))
    ..cadastrarPessoa(Pessoa('Abdul', Mes.janeiro))
    ..cadastrarPessoa(Pessoa('Jean', Mes.abril));

  for (final mes in controleDePessoas.mesesComPessoas) {
    print('\n${mes.name}');
    for (final pessoa in controleDePessoas.pessoasPorMes(mes)) {
      print(' > ${pessoa.nome}');
    }
  }
}

enum Mes {
  janeiro, fevereiro, marco, abril, maio, junho,
  julho, agosto, setembro, outubro, novembro, dezembro,
}

class Pessoa {
  Pessoa(this.nome, this.mesDeNascimento);

  final String nome;
  final Mes mesDeNascimento;
}

class ControleDePessoas {
  final Map<Mes, List<Pessoa>> _pessoasPorMes = {};

  void cadastrarPessoa(Pessoa pessoa) {
    final mes = pessoa.mesDeNascimento;

    if (_pessoasPorMes[mes] == null) {
      _pessoasPorMes[mes] = [];
    }

    _pessoasPorMes[mes]!.add(pessoa);
  }

  List<Mes> get mesesComPessoas {
    final meses = _pessoasPorMes.keys.toList();
    meses.sort((a, b) => a.index.compareTo(b.index));
    return meses;
  }

  List<Pessoa> pessoasPorMes(Mes mes) {
    return _pessoasPorMes[mes] ?? [];
  }
}