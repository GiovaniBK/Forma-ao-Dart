import 'package:apf6_funcoes/utils/tipos_sanguineos.dart';

class Pessoa {
  const Pessoa({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.github,
    required this.tipoSanguineo,
  });

  final String nome;
  final String email;
  final String telefone;
  final String github;
  final TipoSanguineo tipoSanguineo;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pessoa &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.github == github &&
        other.tipoSanguineo == tipoSanguineo;
  }

  @override
  int get hashCode => Object.hash(nome, email, telefone, github, tipoSanguineo);
}
