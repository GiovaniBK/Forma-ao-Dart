void main() {
  // Criar mapa com chave (sigla) e valor (lista de cidades)
  final mapa = {
    'SC': ['Gaspar', 'Blumenau', 'Florianopolis'],
    'PR': ['Curitiba', 'Cascavel', 'Foz do Iguacu'],
    'SP': ['Sao Paulo', 'Guarulhos', 'Campinas'],
    'MG': ['Belo Horizonte', 'Juiz de Fora', 'Berlinda'],
  };

  // Imprimir siglas dos estados
  print('Estados: ${mapa.keys.join(' ; ')}');

  // Imprimir cidades de SC em ordem alfabética
  final cidadesSC = mapa['SC']!..sort();
  print('Cidades de SC: ${cidadesSC.join(' ; ')}');

  // Imprimir todas as cidades em ordem alfabética no formato "Cidade - Estado"
  List<String> todasCidades = [];
  mapa.forEach((estado, cidades) {
    for (String cidade in cidades) {
      todasCidades.add('$cidade - $estado');
    }
  });
  // Ordenar alfabeticamente todas as cidades
  todasCidades.sort();
  for (String linha in todasCidades) {
    print(linha);
  }
}