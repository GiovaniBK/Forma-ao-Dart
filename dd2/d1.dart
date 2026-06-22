// NAO PODE SER MODIFICADO
// -------------------------------------------------------------
import 'dart:math' as math;

void main() {
  final meioDeComunicacao = aleatorio();
  meioDeComunicacao.fazerLigacao('(47) 99876-5432');
}

MeioDeComunicacao aleatorio() {
  final meiosDeComunicacao = <MeioDeComunicacao>[
    Telefone(),
    Celular(),
    Orelhao(),
  ];

  final random = math.Random();

  return meiosDeComunicacao[random.nextInt(
    meiosDeComunicacao.length,
  )];
}

// -------------------------------------------------------------
// ADICIONAR IMPLEMENTACAO RESTANTE ABAIXO DESSA LINHA
// -------------------------------------------------------------

class MeioDeComunicacao {
  // Método base que representa o ato de fazer uma ligação. As
  // subclasses podem herdar esse comportamento ou sobrescrever
  // para customizar o texto exibido.
  void fazerLigacao(String numero) {
    print("[${aleatorio().toString().toUpperCase()}] Ligando para $numero...");
  }
}

class Telefone extends MeioDeComunicacao{
  // Identificação textual da subclasse Telefone
  @override
  String toString() => 'TELEFONE';
}

class Celular extends MeioDeComunicacao{
  // Identificação textual da subclasse Celular
  @override
  String toString() => 'CELULAR';
}

class Orelhao extends MeioDeComunicacao{
  // Identificação textual da subclasse Orelhao
  @override
  String toString() => 'ORELHÃO';
}
