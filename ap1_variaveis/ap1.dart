void main() {
  // Declarando as variáveis
  String nome = 'Giovani';
  String sobrenome = 'Kretzer';
  int idade = 18;
  bool ativo = true;
  double peso = 70.5;
  String? nacionalidade = "Brasileiro";
  
  // Imprimir no console, com a formatação especificada
  print("Nome completo: $nome $sobrenome");

  // Verificar maioridade
  if (idade >= 18) {
    print("Idade: $idade (maior de idade)");
  } else {
    print("Idade: $idade (menor de idade)");
  }

  // Verificar status ativo
  if (ativo = true) {
    print("Situação: Ativo");
  } else {
    print("Situação: Inativo");
  }

  // Formatar double com 2 casas decimais
  print("Peso: ${peso.toStringAsFixed(2)}");

  // Verificar se nacionalidade é nula (null checking)
  if (nacionalidade != null) {
    print("Nacionalidade: $nacionalidade");
  } else {
    print("Nacionalidade: Nao informada");
  }
}
