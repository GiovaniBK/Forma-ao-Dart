import 'dart:io';
import 'dart:math';
import 'package:yaansi/yaansi.dart';

void main() async {
  // Entrada assíncrona do programa.
  final pasta = Directory('C:\\CLIMA\\sensores');
  // Encaminha o diretório base para a camada de seleção do relatório.
  await relatorio(pasta);
}

Future<void> relatorio(Directory pasta) async {
  // Menu inicial para o usuário escolher o tipo de relatório.
  print('OLÁ, LEANDRO. QUE RELATÓRIO VOCÊ PRECISA?');
  print('1 - TEMPERATURA');
  print('2 - UMIDADE');
  print('3 - DIREÇÃO DO VENTO');
  stdout.write('DIGITE O NÚMERO DA OPÇÃO DESEJADA: ');
  int resposta = int.parse(stdin.readLineSync()!);

  switch (resposta) {
    case 1:
      await relatorioTemperatura(pasta);
      break;
    case 2:
      await relatorioUmidade(pasta);
      break;
    case 3:
      await relatorioDirecaoVento(pasta);
      break;
    default:
      // Nenhuma rota é executada quando a entrada não corresponde a uma opção esperada.
      print('Opção inválida, tente novamente');
      relatorio(pasta); // Chamada recursiva para reiniciar o menu.
      break;
  }
}

Future<void> relatorioTemperatura(Directory pasta) async {
  // O buffer acumula a saída já formatada para que o texto impresso possa ser regravado depois sem cores ANSI.
  final buffer = StringBuffer();
  void imprimir(String texto) {
    print(texto);
    buffer.writeln(removerCores(texto));
  }

  // Cada mapa funciona como uma tabela de agregação: o estado é a chave principal e a lista guarda as leituras para calcular média, mínimo e máximo.
  final Map<String, List<double>> leiturasPorEstado = {'SC': [], 'SP': []};
  // Agrupa as leituras por mês para calcular estatísticas mensais
  final Map<String, Map<int, List<double>>> leiturasPorMes = {'SC': {}, 'SP': {}};
  final Map<String, Map<int, List<double>>> leiturasPorHora = {'SC': {}, 'SP': {}};

  // Lê os CSVs da pasta e separa os dados por estado.
  await for (final entidade in pasta.list()) {
    if (entidade is! File || !entidade.path.endsWith('.csv')) continue;

    String? estado;
    if (entidade.path.contains('SC')) {
      estado = 'SC';
    } else if (entidade.path.contains('SP')) {
      estado = 'SP';
    } else {
      continue;
    }

    try {
      // Leitura e processamento das linhas do arquivo CSV.
      // O cabeçalho é ignorado com `i = 1`.
      final linhas = await entidade.readAsLines();

      for (var i = 1; i < linhas.length; i++) {
        final dados = linhas[i].split(',');
        if (dados.length < 4) continue;

        final int mes = int.parse(dados[0].trim());
        final int hora = int.parse(dados[2].trim());
        final double temperatura = double.parse(dados[3].trim());

        // `putIfAbsent` cria a lista sob demanda, evitando inicialização manual de meses/horas sem dados.
        leiturasPorEstado[estado]!.add(temperatura);
        leiturasPorMes[estado]!.putIfAbsent(mes, () => []).add(temperatura);
        leiturasPorHora[estado]!.putIfAbsent(hora, () => []).add(temperatura);
      }
    } catch (e) {
      print('Falha na leitura do arquivo ${entidade.path}: $e');
      continue;
    }
  }

  // Cabeçalho do relatório e unidades.
  imprimir('Relatório de Temperatura: (°C: Celsius, °F: Fahrenheit, K: Kelvin)\n');

  imprimir('Média por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final lista = leiturasPorEstado[estado]!;
    if (lista.isEmpty) continue;
    final media = lista.reduce((a, b) => a + b) / lista.length; // Calcula a média anual de temperatura por list.reduce
    imprimir('$estado: ${media.toStringAsFixed(2).red}°C | ${fahrenheit(media).toStringAsFixed(2).yellow}°F | ${kelvin(media).toStringAsFixed(2).blue}K');
  }

  imprimir('\nMédia por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = leiturasPorMes[estado]!;
    // A ordenação das chaves garante que o relatório mensal saia em ordem cronológica, mesmo que o CSV venha fora de ordem.
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final lista = meses[mes]!;
      final media = lista.reduce((a, b) => a + b) / lista.length;
      imprimir('${Meses.values[mes - 1].name}: ${media.toStringAsFixed(2).red}°C | ${fahrenheit(media).toStringAsFixed(2).yellow}°F | ${kelvin(media).toStringAsFixed(2).blue}K');
    }
  }

  imprimir('\nMáxima por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final lista = leiturasPorEstado[estado]!;
    if (lista.isEmpty) continue;
    final maxima = lista.reduce((a, b) => a > b ? a : b); // Calcula a máxima anual de temperatura por list.reduce.
    imprimir('$estado: ${maxima.toStringAsFixed(2).red}°C | ${fahrenheit(maxima).toStringAsFixed(2).yellow}°F | ${kelvin(maxima).toStringAsFixed(2).blue}K');
  }

  imprimir('\nMáxima por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = leiturasPorMes[estado]!;
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final lista = meses[mes]!;
      final maxima = lista.reduce((a, b) => a > b ? a : b); // Calcula a máxima mensal de temperatura por list.reduce.
      imprimir('${Meses.values[mes - 1].name}: ${maxima.toStringAsFixed(2).red}°C | ${fahrenheit(maxima).toStringAsFixed(2).yellow}°F | ${kelvin(maxima).toStringAsFixed(2).blue}K');
    }
  }

  imprimir('\nMínima por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final lista = leiturasPorEstado[estado]!;
    if (lista.isEmpty) continue;
    final minima = lista.reduce((a, b) => a < b ? a : b); // Calcula a mínima anual de temperatura por list.reduce
    imprimir('$estado: ${minima.toStringAsFixed(2).red}°C | ${fahrenheit(minima).toStringAsFixed(2).yellow}°F | ${kelvin(minima).toStringAsFixed(2).blue}K');
  }

  imprimir('\nMínima por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = leiturasPorMes[estado]!;
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final lista = meses[mes]!;
      final minima = lista.reduce((a, b) => a < b ? a : b); // Calcula a mínima mensal de temperatura por list.reduce
      imprimir('${Meses.values[mes - 1].name}: ${minima.toStringAsFixed(2).red}°C | ${fahrenheit(minima).toStringAsFixed(2).yellow}°F | ${kelvin(minima).toStringAsFixed(2).blue}K');
    }
  }

  imprimir('\nMédia por horário por estado:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final horas = leiturasPorHora[estado]!;
    final chaves = horas.keys.toList()..sort();
    for (final hora in chaves) {
      final lista = horas[hora]!;
      final media = lista.reduce((a, b) => a + b) / lista.length;
      final horaFormatada = hora.toString().padLeft(2, '0'); // Formata a hora para sempre ter dois dígitos
      imprimir('${horaFormatada}h: ${media.toStringAsFixed(2).red}°C | ${fahrenheit(media).toStringAsFixed(2).yellow}°F | ${kelvin(media).toStringAsFixed(2).blue}K');
    }
  }

  // Salva a saída somente se o usuário confirmar.
  await salvarRelatorio('CLIMA', buffer);
}

Future<void> relatorioUmidade(Directory pasta) async {
  // Mesmo padrão de buffer usado no relatório de temperatura.
  final buffer = StringBuffer();
  void imprimir(String texto) {
    print(texto);
    buffer.writeln(removerCores(texto));
  }

  final Map<String, List<double>> leiturasPorEstado = {'SC': [], 'SP': []};
  final Map<String, Map<int, List<double>>> leiturasPorMes = {'SC': {}, 'SP': {}};

  // A leitura é igual a da temperatura, apenas muda o índice da coluna lida (coluna 4 para umidade).
  await for (final entidade in pasta.list()) {
    if (entidade is! File || !entidade.path.endsWith('.csv')) continue;

    String? estado;
    if (entidade.path.contains('SC')) {
      estado = 'SC';
    } else if (entidade.path.contains('SP')) {
      estado = 'SP';
    } else {
      continue;
    }

    try {
      // Cada linha é dividida por vírgula e a coluna 4 é convertida para `double`.
      final linhas = await entidade.readAsLines();

      for (var i = 1; i < linhas.length; i++) {
        final dados = linhas[i].split(',');
        if (dados.length < 5) continue;

        final int mes = int.parse(dados[0].trim());
        final double umidade = double.parse(dados[4].trim());

        // Os valores ficam em listas para calcular outras estatísticas depois.
        leiturasPorEstado[estado]!.add(umidade);
        leiturasPorMes[estado]!.putIfAbsent(mes, () => []).add(umidade);
      }
    } catch (e) {
      print('Falha na leitura do arquivo ${entidade.path}: $e');
      continue;
    }
  }

  imprimir('Relatório de Umidade:\n');

  imprimir('Média por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final lista = leiturasPorEstado[estado]!;
    if (lista.isEmpty) continue;
    final media = lista.reduce((a, b) => a + b) / lista.length;
    imprimir('$estado: ${media.toStringAsFixed(6).green}');
  }

  imprimir('\nMédia por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = leiturasPorMes[estado]!;
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final lista = meses[mes]!;
      final media = lista.reduce((a, b) => a + b) / lista.length;
      imprimir('${Meses.values[mes - 1].name}: ${media.toStringAsFixed(6).green}');
    }
  }

  imprimir('\nMáxima por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final lista = leiturasPorEstado[estado]!;
    if (lista.isEmpty) continue;
    final maxima = lista.reduce((a, b) => a > b ? a : b);
    imprimir('$estado: ${maxima.toStringAsFixed(6).red}');
  }

  imprimir('\nMáxima por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = leiturasPorMes[estado]!;
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final lista = meses[mes]!;
      final maxima = lista.reduce((a, b) => a > b ? a : b);
      imprimir('${Meses.values[mes - 1].name}: ${maxima.toStringAsFixed(6).red}');
    }
  }

  imprimir('\nMínima por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final lista = leiturasPorEstado[estado]!;
    if (lista.isEmpty) continue;
    final minima = lista.reduce((a, b) => a < b ? a : b);
    imprimir('$estado: ${minima.toStringAsFixed(6).blue}');
  }

  imprimir('\nMínima por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = leiturasPorMes[estado]!;
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final lista = meses[mes]!;
      final minima = lista.reduce((a, b) => a < b ? a : b);
      imprimir('${Meses.values[mes - 1].name}: ${minima.toStringAsFixed(6).blue}');
    }
  }

  // Exporta o resultado final, se o usuário quiser.
  await salvarRelatorio('UMIDADE', buffer);
}

Future<void> relatorioDirecaoVento(Directory pasta) async {
  // Neste relatório a unidade analisada é a frequência de ocorrência da direção
  final buffer = StringBuffer();
  void imprimir(String texto) {
    print(texto);
    buffer.writeln(removerCores(texto));
  }
  
  final Map<String, Map<int, Map<int, int>>> contagemPorMes = {'SC': {}, 'SP': {}};
  final Map<String, Map<int, int>> contagemAnual = {'SC': {}, 'SP': {}};

  // Lê os arquivos e soma as direções encontradas.
  await for (final entidade in pasta.list()) {
    if (entidade is! File || !entidade.path.endsWith('.csv')) continue;

    String? estado;
    if (entidade.path.contains('SC')) {
      estado = 'SC';
    } else if (entidade.path.contains('SP')) {
      estado = 'SP';
    } else {
      continue;
    }

    try {
      // O índice 7 é a coluna da direção, a conversão para inteiro permite usar a direção como chave do Map
      final linhas = await entidade.readAsLines();

      for (var i = 1; i < linhas.length; i++) {
        final dados = linhas[i].split(',');
        if (dados.length < 8) continue;

        final int mes = int.parse(dados[0].trim());
        final int direcao = int.parse(dados[7].trim());

        // Atualiza a contagem anual e mensal da direção.
        contagemAnual[estado]![direcao] = (contagemAnual[estado]![direcao] ?? 0) + 1;

        contagemPorMes[estado]!.putIfAbsent(mes, () => {});
        final map = contagemPorMes[estado]![mes]!;
        map[direcao] = (map[direcao] ?? 0) + 1;
      }
    } catch (e) {
      print('Falha na leitura do arquivo ${entidade.path}: $e');
      continue;
    }
  }

  // A moda é obtida com `reduce`, comparando os pares por valor e preservando o maior contador
  int frequenciaDirecao(Map<int, int> contagem) =>
      contagem.entries.reduce((a, b) => a.value >= b.value ? a : b).key;

  imprimir('Relatório de Direção do Vento:\n');

  imprimir('Direção com maior frequência por estado por ano:\n');
  for (final estado in ['SC', 'SP']) {
    final contagem = contagemAnual[estado]!;
    if (contagem.isEmpty) continue;
    final moda = frequenciaDirecao(contagem);
    imprimir('$estado: ${moda.toString().yellow}° | ${radianos(moda).toStringAsFixed(2).yellow} rad');
  }

  imprimir('\nDireção com maior frequência por estado por mês:\n');
  for (final estado in ['SC', 'SP']) {
    imprimir('$estado:');
    final meses = contagemPorMes[estado]!;
    final chaves = meses.keys.toList()..sort();
    for (final mes in chaves) {
      final moda = frequenciaDirecao(meses[mes]!);
      imprimir('${Meses.values[mes - 1].name}: ${moda.toString().yellow}° | ${radianos(moda).toStringAsFixed(2).yellow} rad');
    }
  }

  // Salva a saída somente se o usuário confirmar.
  await salvarRelatorio('VENTO', buffer);
}

Future<void> salvarRelatorio(String prefixo, StringBuffer buffer) async {
  // Pergunta ao usuário antes de salvar o arquivo
  stdout.write('\nDESEJA SALVAR ESTE RELATÓRIO EM ARQUIVO TXT? (S/N): ');
  final resposta = stdin.readLineSync()?.trim().toUpperCase() ?? '';
  if (resposta != 'S') return;

  try {
    // Monta um nome com data e hora
    final agora = DateTime.now();
    final data = '${agora.year}-${agora.month.toString().padLeft(2, '0')}-${agora.day.toString().padLeft(2, '0')}';
    final hora = '${agora.hour.toString().padLeft(2, '0')}-${agora.minute.toString().padLeft(2, '0')}';
    final nomeArquivo = '${prefixo}_${data}_$hora.txt';

    // `create(recursive: true)` garante a existência da pasta mesmo se ela ainda não existir.
    final diretorio = Directory('${Directory.current.path}\\relatorios');
    if (!await diretorio.exists()) await diretorio.create(recursive: true);

    // O buffer já está livre de sequencias ANSI, por isso o arquivo final fica limpo e legível fora do terminal.
    final arquivo = File('${diretorio.path}\\$nomeArquivo');
    await arquivo.writeAsString(buffer.toString());

    print('Relatório salvo em "$nomeArquivo"!');
  } catch (e) {
    print('Erro ao salvar o arquivo: $e');
  }
}

enum Meses {
  janeiro, fevereiro, marco, abril, maio, junho,
  julho, agosto, setembro, outubro, novembro, dezembro,
}

// Conversões matematicas usadas na apresentação dos resultados.
double fahrenheit(double celsius) => (celsius * 9 / 5) + 32;
double kelvin(double celsius) => celsius + 273.15;
double radianos(num graus) => graus * (pi / 180);

// Remove códigos ANSI (cores no texto) porque o terminal os interpreta, mas não o TXT.
String removerCores(String texto){
  return texto.replaceAll(RegExp(r'\x1B\[[0-?]*[ -/]*[@-~]'), '');
}