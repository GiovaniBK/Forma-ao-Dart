void main(){
  const pessoa = Pessoa("Giovani", "Kretzer", 18, true, 70.5, "Brasileiro");
  // Imprimir os dados da pessoa usando toString()
  print(pessoa.toString());
}

// Classe que representa uma pessoa com seus atributos básicos
class Pessoa {
  // Construtor constante recebendo todos os parâmetros
  const Pessoa(
    this.nome,
    this.sobrenome,
    this.idade,
    this.ativo,
    this.peso,
    this.nacionalidade,
  );

  final String nome;
  final String sobrenome;
  final int idade;
  final bool ativo;
  final double peso;
  final String? nacionalidade;  // Pode ser nulo

  // Sobrescrever o método toString para formatação customizada
  @override
  String toString() {
    var imprimirFormatado = "";

    // Construir string formatada com os dados da pessoa
    imprimirFormatado += "Nome completo: $nome $sobrenome\n";

    if (idade >= 18) {
      imprimirFormatado += "Idade: $idade (maior de idade)\n";
    } else {
      imprimirFormatado += "Idade: $idade (menor de idade)\n";
    }

    if (ativo) {
      imprimirFormatado += "Situação: Ativo\n";
    } else {
      imprimirFormatado += "Situação: Inativo\n";
    }

    imprimirFormatado += "Peso: ${peso.toStringAsFixed(2)}\n";

    if (nacionalidade != null) {
      imprimirFormatado += "Nacionalidade: $nacionalidade\n";
    } else {
      imprimirFormatado += "Nacionalidade: Nao informada\n";
    }

    return imprimirFormatado;
  }
}