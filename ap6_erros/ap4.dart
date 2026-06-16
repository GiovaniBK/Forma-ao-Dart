void main() {
  try {
    String nome = 'documento.txt';
    var arquivo = ArquivoTexto(nome);
    arquivo.abrir();
  } catch (e) {
    // Capturar exceção lançada
    print(e);
  } finally {
    // Bloco finally sempre executa, mesmo com exceção
    print('Fim do programa');
  }
}

abstract interface class Arquivo {
  void abrir();
}

// Classe que implementa Arquivo
class ArquivoTexto implements Arquivo {
  final String nome;

  ArquivoTexto(this.nome);

  @override
  void abrir() {
    try {
      // Lançar exceção simulando erro ao abrir arquivo
      throw Exception('Erro ao abrir o arquivo $nome');
    } catch (e) {
      // Relançar a exceção para ser tratada no escopo superior
      rethrow;
    }
  }
}
