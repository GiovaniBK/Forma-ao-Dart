void main() {
  // Cria uma instância de Caminhão
  final caminhao = Caminhao("caminhão");

  // Chama o método pilotar (da interface Veiculo)
  caminhao.pilotar();
  // Chama o método descarregar (da interface Carga)
  caminhao.descarregar();
}

// Classe abstrata veículos
abstract class Veiculo {
  String nome;

  Veiculo(this.nome);

  // Método abstrato que deve ser implementado por quem implementar esta classe
  void pilotar();
}

// Classe abstrata carga
abstract class Carga {
  // Método abstrato para descarregar
  void descarregar();
}

// Classe Caminhao que implementa DUAS classes: Veiculo e Carga
class Caminhao implements Veiculo, Carga {
  // Propriedade herdada da classe Veiculo
  @override
  String nome;

  Caminhao(this.nome);

  // Implementação do método pilotar
  void pilotar() {
    print("Alguém está pilotando o $nome.");
  }

  // Implementação do método descarregar
  void descarregar() {
    print("O $nome está sendo descarregado.");
  }
}
