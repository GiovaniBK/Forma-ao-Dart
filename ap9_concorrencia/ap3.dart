Future<void> main() async {
  print('Iniciando lançamento');

  // Loop de contagem regressiva de 5 até 1
  for (var i = 5; i > 0; i--) {
    print("$i...");
    // Aguarda 1 segundo entre cada contagem
    await Future.delayed(Duration(seconds: 1));
  }

  // Exibido após a contagem terminar
  print('Foguete lançado!');
}