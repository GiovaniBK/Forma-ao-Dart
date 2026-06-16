void main() {
  try {
    String nome = 'documento.txt';
    var arquivo = ArquivoTexto(nome);
    arquivo.abrir();
  } catch (e) {
    print(e);
  } finally {
    print('Fim do programa');
  }
}

abstract interface class Arquivo {
  void abrir();
}

class ArquivoTexto implements Arquivo {
  final String nome;

  ArquivoTexto(this.nome);

  @override
  void abrir() {
    try {
      throw Exception('Erro ao abrir o arquivo $nome');
    } catch (e) {
      rethrow;
    }
  }
}
