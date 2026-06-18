void main() {
  // Obtém a data atual
  final dataAtual = DateTime.now();
  // Adiciona 18 dias de trabalho à data atual (ignorando sábados e domingos)
  final dataCalculada = calculaData(dataAtual, 18);
  
  // Exibe a data atual formatada
  print('Data atual: ${dataAtual.day}/${dataAtual.month}/${dataAtual.year}');
  // Exibe a data calculada (+18 dias, ignorando sábados e domingos)
  print('Data calculada: ${dataCalculada.day}/${dataCalculada.month}/${dataCalculada.year}');
}

//Função que recebe uma data e um numero de dias,
//e retorna a data somada aos dias, ignorando sabádos e domingos
DateTime calculaData(DateTime data, int dias) {
  int contador = 0;
  DateTime dataCalculada = data;

  //Loop que adiciona dias a data recebida como parametro da função,
  //e acaba quando a variavel contador for igual ao numero recebido como parametro da função
  while (contador < dias) {
    // Verifica se é fim de semana
    if (dataCalculada.weekday == DateTime.sunday || dataCalculada.weekday == DateTime.saturday) {
      // Se for fim de semana, apenas avança um dia sem contar
      dataCalculada = dataCalculada.add(const Duration(days: 1));
    } else {
      // Se for dia útil, avança um dia e incrementa o contador
      dataCalculada = dataCalculada.add(const Duration(days: 1));
      contador++;
    }
  }
  return dataCalculada;
}
