void main() async {
  await buscarDados();
}

// Função que simula o processo completo de busca, localização e extração de dados
Future<void> buscarDados() async {
  print("Buscando dados.");

  // Aguarda 2 segundos simulando a busca de dados
  await Future.delayed(Duration(seconds: 2));

  print("Dados encontrados.");

  // Aguarda 1 segundo para preparar a extração
  await Future.delayed(Duration(seconds: 1));

  print("Fazendo extração dos dados.");

  // Loop que simula o progresso da extração (0% a 100%)
  for (var i = 1; i < 10; i++) {
    print("Porcentagem da extração: ${i*10}%");
    // Aguarda 500ms entre cada incremento de progresso
    await Future.delayed(Duration(milliseconds: 500));
  }

  // Status final
  print("Porcentagem da extração: 100%");
  print("Extração concluída");
}